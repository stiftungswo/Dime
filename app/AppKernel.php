<?php
use Symfony\Component\HttpKernel\Kernel;
use Symfony\Component\Config\Loader\LoaderInterface;

class AppKernel extends Kernel
{

	public function registerBundles()
	{
		$bundles = array(

			// symfony-standard edition
			new Symfony\Bundle\FrameworkBundle\FrameworkBundle(),
			new Symfony\Bundle\SecurityBundle\SecurityBundle(),
			new Symfony\Bundle\TwigBundle\TwigBundle(),
			new Symfony\Bundle\MonologBundle\MonologBundle(),
			new Symfony\Bundle\SwiftmailerBundle\SwiftmailerBundle(),
			new Symfony\Bundle\AsseticBundle\AsseticBundle(),
			new Doctrine\Bundle\DoctrineBundle\DoctrineBundle(),
			new Sensio\Bundle\FrameworkExtraBundle\SensioFrameworkExtraBundle(),

			// vendor packages
			new Doctrine\Bundle\MigrationsBundle\DoctrineMigrationsBundle(),
			new Doctrine\Bundle\FixturesBundle\DoctrineFixturesBundle(),
			new Stof\DoctrineExtensionsBundle\StofDoctrineExtensionsBundle(),
			new Ps\PdfBundle\PsPdfBundle(),
			new FOS\UserBundle\FOSUserBundle(),
			new FOS\RestBundle\FOSRestBundle(),
			new JMS\SerializerBundle\JMSSerializerBundle($this),
			new Nelmio\ApiDocBundle\NelmioApiDocBundle(),
			new \Knp\JsonSchemaBundle\KnpJsonSchemaBundle(),
			new \Swo\CommonsBundle\SwoCommonsBundle(),
			new \Misd\PhoneNumberBundle\MisdPhoneNumberBundle(),
			new \Tbbc\MoneyBundle\TbbcMoneyBundle(),
			
			//Own Bundles
			new Dime\PrintingBundle\DimePrintingBundle(),
			new Dime\FrontendBundle\DimeFrontendBundle(),
			new Dime\OfferBundle\DimeOfferBundle(),
			new Dime\InvoiceBundle\DimeInvoiceBundle(),
			new Dime\EmployeeBundle\DimeEmployeeBundle(),
			new Dime\ReportBundle\DimeReportBundle(),
			new Dime\TimetrackerBundle\DimeTimetrackerBundle(),
		);

		if (in_array($this->getEnvironment(), array(
			'dev',
			'test'
		))) {
			$bundles[] = new Symfony\Bundle\WebProfilerBundle\WebProfilerBundle();
			$bundles[] = new Sensio\Bundle\DistributionBundle\SensioDistributionBundle();
			$bundles[] = new Sensio\Bundle\GeneratorBundle\SensioGeneratorBundle();
			$bundles[] = new h4cc\AliceFixturesBundle\h4ccAliceFixturesBundle();
		}

		return $bundles;
	}

	public function registerContainerConfiguration(LoaderInterface $loader)
	{
		$loader->load(__DIR__ . '/config/config_' . $this->getEnvironment() . '.yml');
	}

	public function getCacheDir()
	{
		return '/dev/shm/dime/cache/' . $this->rootDir . '/' . $this->environment;
	}

	public function getLogDir()
	{
		return '/dev/shm/dime/log/' . $this->rootDir . '/' . $this->environment;
	}
}
