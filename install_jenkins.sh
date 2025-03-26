#!/bin/sh
sudo apt update
sudo apt install ca-certificates -y
# Install Java
sudo apt install openjdk-17-jre-headless -y
# Add Jenkins repository
wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] http://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install jenkins -y
# Install Maven
sudo apt install maven -y
# Install Terraform
sudo apt install gpg -y
wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt install terraform -y
# Start Jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins
# Display Jenkins initial admin password
echo 'Jenkins is installed.'
echo 'This is the default password: ' $(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)
