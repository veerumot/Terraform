In the main.tf file consists of the code for creating a Instance, Security groups, Ec2 key pair for SSH into the Instance.
The userdata.sh is used for installing the apache reverse proxy and run a simple web page with html code.
The userdata is passed to the instance while launching and installs specifications.
In the main.tf file it first creates the secuirty group and key pair. Then it launches the Instance. If the Instance is created before the Security groups and key pair Include depends_on while creating the Instance. As example I have provided it in the main.tf file under ec2 resource for key pair. 
I have created a security group with rules which passes the traffic to 80, 22, and all traffic to check the application works or not. As per the question you can remove the all traffic rule and provide the template. I have provided the CIDR range as internet traffic you cna change it to as per your requirement.
For creating key pair you need generate the public and private keys using keygen. Provide the public key in main.tf file key pair resource public key and the private is used for SSH into the Instance. You need changes the permisions to the private key and make it into a pem file.
  
