<?php

namespace app\index\model;

use think\Model;

class Member extends Model {

    public static function Verify($auth) {

        if (is_string($auth)) {
            $Member = json_decode(think_decrypt($auth), true);
            $cache_Member = cache('Member_' . md5($Member['email']));
            if ($cache_Member == $auth && $cache_Member) {
                return ['login' => true, 'email' => $Member['email'], 'auth' => $auth];
            }
            //return json(['status' => 'error', 'msg' => '登陸超時，請重新登陸']);
            return false;
        }

        if (!$auth || !array_key_exists('email', $auth) || !array_key_exists('password', $auth)) {
            return false;
        }

        $Member = self::where(['email' => $auth['email'], 'password' => $auth['password']])->find();
        if ($Member) {
            cache('Member_' . md5($auth['email']), think_encrypt(json_encode($Member)), config('cache_expire'));
            return ['login' => true, 'email' => $Member['email'], 'auth' => cache('Member')];
        }
        //return json(['status' => 'error', 'msg' => '你還沒有註冊']);
        return false;
    }

}
