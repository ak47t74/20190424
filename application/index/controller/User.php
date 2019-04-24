<?php

namespace app\index\controller;

use think\Request;
use app\index\model\Member;
use think\Db;

class User {

    protected $request;

    public function __construct(Request $request) {
        $this->request = $request;
    }

    /**
     * 充值寫入
     * @return type
     */
    public function setPayment() {
        $_data = [
            'auth' => $this->request->param('auth'),
            'amount' => $this->request->param('amount')
        ];

        $Member = Member::Verify($_data['auth']);
        if ($Member == false) {
            return json(['status' => 'error', 'msg' => '登陸超時，請重新登陸']);
        }

        // 事務處理
        Db::startTrans();
        try {
            $return = Db::table('member')->where('email', $Member['email'])->setInc('bean', $_data['amount']);
            if ($return) {
                $payment_id = DB::table('payment_records')->insertGetId([
                    'payment_no' => date('YmdHis') . time(),
                    'item_name' => '圖書幣',
                    'email' => $Member['email'],
                    'amount' => $_data['amount'],
                    'payment_time' => time()
                ]);
                if ($payment_id) {
                    // 提交事務
                    Db::commit();
                    return json(['status' => 'success', 'msg' => '充值成功']);
                }
            }
            // 回滾事務
            Db::rollback();
            return json(['status' => 'error', 'msg' => $return]);
        } catch (\Exception $e) {
            // 回滾事務
            Db::rollback();
            return json(['status' => 'error', 'msg' => $e->getMessage()]);
        }
    }

    /**
     * 充值列表
     * @return type
     */
    public function getPaymentList() {
        $_data = [
            'auth' => $this->request->param('auth'),
            'page' => $this->request->param('page'),
            'limit' => $this->request->param('limit')
        ];

        $Member = Member::Verify($_data['auth']);
        if ($Member == false) {
            return json(['status' => 'error', 'msg' => '登陸超時，請重新登陸']);
        }
        $payment_records = Db::table('payment_records')->where('email', $Member['email'])->page($_data['page'], $_data['limit'])->order('payment_time')->select();
        return json(['email' => $Member['email'], 'payment_records' => $payment_records]);
    }

    /**
     * 收藏夾
     * @return type
     */
    public function setCollect() {
        $_data = [
            'auth' => $this->request->param('auth'),
            'bid' => $this->request->param('bid'),
            'cid' => $this->request->param('cid')
        ];
		//進行會員auth驗證
        $Member = Member::Verify($_data['auth']);
        if ($Member == false) {
            return json(['status' => 'error', 'msg' => '登陸超時，請重新登陸']);
        }
		//檢查書籍章節編號對應是否正確
		$cid = Db::table('chapter')->where(['bid'=>$_data['bid'],'cid'=>$_data['cid']])->value('cid');
		
		if(empty($cid)){
			return json(['status' => 'error', 'msg' => '書籍章節信息錯誤']);
		}
		//檢查是否已收藏過
		$fid = Db::table('favorites')->where(['bid'=>$_data['bid'],'cid'=>$_data['cid'],'email'=>$Member['email']])->value('fid');
		
		if($fid){
			return json(['status' => 'error', 'msg' => '該書籍章節已收藏過']);
		}
		//寫入資料庫
        $fid = DB::table('favorites')->insertGetId([
            'email' => $Member['email'],
            'bid' => $_data['bid'],
            'cid' => $_data['cid'],
            'jointime' => time()
        ]);
        if ($fid) {
            return json(['status' => 'success', 'msg' => '已加入收藏']);
        }
        return json(['status' => 'error', 'msg' => '加入收藏失敗']);
    }

    /**
     * 收藏夾列表
     * @return type
     */
    public function getCollectList() {
        $_data = [
            'auth' => $this->request->param('auth'),
            'page' => $this->request->param('page'),
            'limit' => $this->request->param('limit')
        ];

        $Member = Member::Verify($_data['auth']);
        
        if ($Member == false) {
            return json(['status' => 'error', 'msg' => '登陸超時，請重新登陸']);
        }

        $favorites_info = Db::query("SELECT a.bid,a.cid,a.jointime,c_title,c_cover,c_description,c_cost FROM favorites a INNER JOIN chapter b ON a.cid = b.cid WHERE a.email = '{$Member['email']}' ORDER BY a.bid,a.cid LIMIT " . (($_data['page'] - 1) * $_data['limit']) . "," . $_data['limit'] . "");
        return json(['email' => $Member['email'], 'favorites_info' => $favorites_info]);
    }

}
