<?php

namespace app\index\validate;

use think\Validate;

class User extends Validate {

    //put your code here
    protected $rule = [
        'password' => 'require|length:6,16',
        'email' => 'require|email'
    ];
    protected $message = [
        'password.length' => 'password必須在6到16之間',
        'email.email' => 'email格式不對',
    ];
    protected $scene = [
        'Register' => ['email', 'password'],
        'Login' => ['email', 'password'],
    ];

}
