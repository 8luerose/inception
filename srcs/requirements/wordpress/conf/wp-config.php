<?php
/**
 * WordPress 기본 설정 파일
 *
 * 이 파일은 설치 중 사용되며, 웹 사이트를 사용하지 않고도 이 파일을 "wp-config.php"로 복사하여 값을 채워 넣을 수 있습니다.
 * 다음 설정들을 포함합니다:
 * - 데이터베이스 설정
 * - 보안 키
 * - 데이터베이스 테이블 접두어
 * - ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 * @package WordPress
 */

// ** 데이터베이스 설정 - 웹 호스팅 제공업체에서 이 정보를 얻을 수 있습니다 ** //

define('DB_NAME', 'mydb');					// WordPress 데이터베이스 이름
// define('DB_NAME', getenv('MYSQL_DATABASE'));		// WordPress 데이터베이스 이름

define('DB_USER', 'taehkwon');      			// MySQL 데이터베이스 사용자 이름
// define('DB_USER', getenv('MYSQL_USER'));      	// MySQL 데이터베이스 사용자 이름

define('DB_PASSWORD', 'password-secret');  			// MySQL 데이터베이스 비밀번호
// define('DB_PASSWORD', getenv('MYSQL_PASSWORD'));  // MySQL 데이터베이스 비밀번호

define('DB_HOST', 'mariadb' );      			// MySQL 호스트 이름
// define('DB_HOST', getenv('MYSQL_HOST'));      	// MySQL 호스트 이름

define('DB_PORT', '3306' );	  				// MySQL 포트 번호

define('DB_CHARSET', 'utf8');                 	// 데이터베이스 생성 시 사용할 문자 집합
define('DB_COLLATE', '');                     	// 데이터베이스 정렬 방식 (확실하지 않다면 변경하지 마세요)

// ** 인증용 고유 키와 솔트 ** //
// 이 값들을 변경하여 모든 기존 쿠키를 무효화하고, 모든 사용자가 다시 로그인하게 할 수 있습니다
// 아래 부분들을 '주석처리' 하면 자동으로 생성된 값이 사용된다
// define('AUTH_KEY', getenv('AUTH_KEY'));
// define('SECURE_AUTH_KEY', getenv('SECURE_AUTH_KEY'));
// define('LOGGED_IN_KEY', getenv('LOGGED_IN_KEY'));
// define('NONCE_KEY', getenv('NONCE_KEY'));
// define('AUTH_SALT', getenv('AUTH_SALT'));
// define('SECURE_AUTH_SALT', getenv('SECURE_AUTH_SALT'));
// define('LOGGED_IN_SALT', getenv('LOGGED_IN_SALT'));
// define('NONCE_SALT', getenv('NONCE_SALT'));

// ** WordPress 데이터베이스 테이블 접두어 ** //
// 하나의 데이터베이스에 여러 WordPress 설치를 운영할 수 있습니다
$table_prefix = 'wp_';

// ** 개발자용: WordPress 디버깅 모드 ** //
define('WP_DEBUG', false);  // 개발 중 문제를 해결하기 위해 참으로 설정

// ** 그만 수정하고 출판을 시작하세요! ** //

/** WordPress 디렉토리의 절대 경로를 설정합니다. */
if (!defined('ABSPATH')) {
    define('ABSPATH', __DIR__ . '/');
}

/** WordPress 변수와 포함된 파일을 설정합니다. */
require_once ABSPATH . 'wp-settings.php';
