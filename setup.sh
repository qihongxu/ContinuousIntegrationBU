#!/bin/bash

echo "Running vagrant configuration script"

echo "Installing Java"
sudo yum install java-1.7.0-openjdk -y
export JAVA_HOME=/usr/lib/jvm/jre-1.7.0-openjdk-1.7.0.75-2.5.4.7.el7_1.x86_64

echo "Installing unzip"
sudo yum install unzip -y

if [ ! -d "/opt/maven" ]; then
	echo "Installing Maven"
	cd /tmp
	wget http://supergsego.com/apache/maven/maven-3/3.3.1/binaries/apache-maven-3.3.1-bin.zip 
	unzip apache-maven-3.3.1-bin.zip 
	sudo rm apache-maven-3.3.1-bin.zip
	mv apache-maven-3.3.1/ /opt/maven
	ln -s /opt/maven/bin/mvn /usr/bin/mvn
	echo "#!/bin/bash
	MAVEN_HOME=/opt/maven
	PATH=\$MAVEN_HOME/bin:\$PATH
	export PATH MAVEN_HOME
	export CLASSPATH=.
	export M2_HOME=/usr/local/maven
	export PATH=\${M2_HOME}/bin:\${PATH}" > /etc/profile.d/maven.sh
	chmod +x /etc/profile.d/maven.sh
	source /etc/profile.d/maven.sh
	cd ..
fi

echo "Installing Git"
sudo yum install git -y

echo "Installing Docker"
sudo yum install docker -y
sudo yum install docker-registry -y

if [ ! -d "/usr/lib/jenkins" ]; then
	echo "Installing Jenkins"
	sudo mkdir jinstall
	cd jinstall
	sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
	sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
	sudo yum install jenkins -y
	sudo rm -r jinstall
	sudo service jenkins start
fi


echo "Installing vim"
sudo yum install vim -y

#echo "Pulling docker image down"

#docker pull rootnotfound/helloworld

echo "Downling the project"
cd /vagrant
sudo git clone https://github.com/qihongxu/swingapp.git


#echo "Installing vagrant"