<?php

namespace Dime\TimetrackerBundle\Tests\Controller;

use Symfony\Bundle\FrameworkBundle\Client;
use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;
use Symfony\Component\BrowserKit\Cookie;

class DimeTestCase extends WebTestCase
{
    /* @var $client Client */
    protected $client;
    const FIREWALL_NAME = 'main';
    protected $api_prefix = '/api/v1';

    public function setUp()
    {
        $this->client = self::createClient();
    }

    protected function request(
        $method,
        $uri,
        $content = null,
        array $server = array(),
        array $parameters = array(),
        array $files = array(),
        $changeHistory = true
    )
    {
        $this->client->request($method, $uri, $parameters, $files, $server, $content, $changeHistory);
        return $this->client->getResponse();
    }

	protected function jsonRequest(
		$method,
		$uri,
		$content = null,
		array $server = array(),
		array $parameters = array(),
		array $files = array(),
		$changeHistory = true
	)
	{
		$server['CONTENT_TYPE'] = 'application/json';
		$server['HTTP_ACCEPT'] = 'application/json';
		$this->client->request($method, $uri, $parameters, $files, $server, $content, $changeHistory);
		return $this->client->getResponse();
	}

	protected function xmlRequest(
		$method,
		$uri,
		$content = null,
		array $server = array(),
		array $parameters = array(),
		array $files = array(),
		$changeHistory = true
	)
	{
		$server['CONTENT_TYPE'] = 'application/xml';
		$server['ACCEPT'] = 'application/xml';
		$this->client->request($method, $uri, $parameters, $files, $server, $content, $changeHistory);
		return $this->client->getResponse();
	}

	/**
	 * User with auth.
	 *
	 * @param $user
	 *
	 * @return Client
	 *
	 */
    protected function loginAs($user)
    {
        $this->client->restart();

        $container = $this->client->getContainer();

        if ($user) {
            $session = $container->get('session');
            /** @var $userManager \FOS\UserBundle\Doctrine\UserManager */
            $userManager = $container->get('fos_user.user_manager');
            /** @var $loginManager \FOS\UserBundle\Security\LoginManager */
            $loginManager = $container->get('fos_user.security.login_manager');
            $firewallName = $container->getParameter('fos_user.firewall_name');

            $user = $userManager->findUserBy(array('username' => $user));
            $loginManager->loginUser($firewallName, $user);

            // save the login token into the session and put it in a cookie
            $container->get('session')->set('_security_' . $firewallName, serialize($container->get('security.context')->getToken()));
            $container->get('session')->save();
            $this->client->getCookieJar()->set(new Cookie($session->getName(), $session->getId()));
        }
    }
}
