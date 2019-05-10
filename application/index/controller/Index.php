<?php

namespace app\index\controller;

use think\Request;
use app\index\model\Member;
use think\Db;

class Index {

    protected $request;

    public function __construct(Request $request) {
        $this->request = $request;
    }

    /**
     * 註冊
     * @return type
     */
    public function Register() {
        $_data = [
            'email' => $this->request->param('email'),
            'password' => $this->request->param('password')
        ];

        $validate = validate('User');

        $result = $validate->scene('Register')->check($_data);

        if (empty($result)) {
            return json(['status' => 'error', 'msg' => $validate->getError()]);
        }

        $_data['password'] = md5(md5($_data['password']));

        if (Member::Verify($_data) !== false) {
            return json(['status' => 'error', 'msg' => '註冊失敗，該郵箱已經註冊了']);
        }

        if (Member::create($_data)) {
            cache('Member_' . md5($_data['email']), think_encrypt(json_encode($_data)), config('cache_expire'));
            return json(['status' => 'success', 'msg' => '會員註冊成功', 'auth' => cache('Member_' . md5($_data['email']))]);
        }
        return json(['status' => 'error', 'msg' => '意外的錯誤']);
    }

    /**
     * 登陸
     * @return type
     */
    public function Login() {

        $_data = [
            'email' => $this->request->param('email'),
            'password' => $this->request->param('password')
        ];

        $validate = validate('User');

        $result = $validate->scene('Login')->check($_data);

        if (empty($result)) {
            return json(['status' => 'error', 'msg' => $validate->getError()]);
        }

        $_data['password'] = md5(md5($_data['password']));

        $User = Member::Verify($_data);
        if ($User) {
            return json(['status' => 'success', 'msg' => '會員登入成功', 'auth' => cache('Member_' . md5($_data['email']))]);
        }

        return json(['status' => 'error', 'msg' => '會員登入失敗']);
    }

    /**
     * 書籍列表
     * @return type
     */
    public function Books() {
        $_data = [
            'auth' => $this->request->param('auth'),
            'page' => $this->request->param('page'),
            'limit' => $this->request->param('limit')
        ];

        $Member = Member::Verify($_data['auth']);

        $booksinfo = Db::table('books')->page($_data['page'], $_data['limit'])->order('bid')->select();

        if ($Member['login'] == true) {
            $Member['booksinfo'] = $booksinfo;
            return json($Member);
        }

        return json([
            'email' => null,
            'login' => false,
            'bean' => 0,
            'booksinfo' => $booksinfo
        ]);
    }

    /**
     * 書籍章節列表
     * @return type
     */
    public function BookView() {
        $_data = [
            'auth' => $this->request->param('auth'),
            'bid' => $this->request->param('bid'),
            'page' => $this->request->param('page'),
            'limit' => $this->request->param('limit')
        ];

        if (empty($_data['bid'])) {
            return json(['status' => 'error', 'msg' => 'bid参数错误']);
        }

        $Member = Member::Verify($_data['auth']);
		
		/* 註冊會員回應的JSON格式 */
        if ($Member) {
            $Member['booksinfo'] = Db::query("SELECT a.bean,b.*,c.*, CASE WHEN a.bean >= c.c_cost THEN 'can_see' ELSE 'no_see' END issee FROM member a, books b, chapter c WHERE a.email = '{$Member['email']}' AND b.bid='{$_data['bid']}' AND b.bid = c.bid ORDER BY b.bid,c.c_order LIMIT " . (($_data['page'] - 1) * $_data['limit']) . "," . $_data['limit'] . "");
            return json($Member);
        }
		
		/* 遊客回應的JSON格式 */
        $booksinfo = Db::query("SELECT b.*,c.*, CASE WHEN c.c_cost = 0 THEN 'can_see' ELSE 'please_login' END issee FROM books b, chapter c WHERE b.bid = c.bid AND b.bid='{$_data['bid']}' ORDER BY b.bid,c_order LIMIT " . (($_data['page'] - 1) * $_data['limit']) . "," . $_data['limit'] . "");
        return json([
            'email' => null,
            'login' => false,
            'bean' => 0,
            'booksinfo' => $booksinfo
        ]);
    }

}
