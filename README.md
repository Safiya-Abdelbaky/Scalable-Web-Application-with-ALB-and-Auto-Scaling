# Scalable Web Application with ALB and Auto Scaling

##  Project Overview
This repository contains the infrastructure design and deployment details for a production-grade, highly available web application on AWS. The architecture is distributed across multiple Availability Zones to ensure fault tolerance and utilizes Auto Scaling and Load Balancing to dynamically handle varying traffic loads. 

To maintain a strict security posture, all compute and database resources are isolated within private subnets, completely eliminating direct public internet access to the servers.

##  Architecture & Traffic Flow (How it Works)
The system is designed following the AWS Well-Architected Framework. The request lifecycle flows as follows:

1. **DNS & Edge Caching:** User requests are initially resolved by **Amazon Route 53**, which routes traffic to an **Amazon CloudFront** distribution. CloudFront caches static assets at edge locations to drastically reduce latency.
2. **Security Inspection:** Dynamic requests pass through **AWS WAF**, which is configured with rules to inspect and mitigate common web vulnerabilities (e.g., OWASP Top 10, SQL injection, XSS).
3. **Traffic Distribution:** Clean traffic reaches the **Application Load Balancer (ALB)** located in the public subnets.
4. **Compute Tier (Isolated):** The ALB securely forwards requests to **Amazon EC2** instances running within an **Auto Scaling Group (ASG)** in the private subnets.
5. **Data Tier (Isolated):** The application reads and writes data to a **Multi-AZ Amazon RDS** instance located in dedicated, secure database subnets.

##  Technology Stack & AWS Services
* **Networking:** VPC, Public & Private Subnets, Internet Gateway, NAT Gateway, Route Tables.
* **Security:** AWS WAF, Security Groups, Network ACLs, IAM.
* **Compute & Scaling:** Amazon EC2, Launch Templates, Auto Scaling Group (Target Tracking Policies).
* **Storage & Database:** Amazon RDS (Multi-AZ with automated failover).
* **Delivery:** Amazon CloudFront, Amazon Route 53.
* **Operations & Monitoring:** AWS Systems Manager (Session Manager), Amazon CloudWatch, Amazon SNS.

##  Key Architectural Decisions & Security Best Practices
* **Bastion-Free Management:** Traditional SSH ports (Port 22) are completely closed. Administrative access to the EC2 instances is managed securely via **AWS Systems Manager (SSM) Session Manager**.
* **Principle of Least Privilege:** Security Groups are strictly configured. The EC2 instances only accept HTTP/HTTPS traffic from the ALB, and the RDS database only accepts Port 3306 (MySQL) traffic from the EC2 Security Group.
* **Outbound Internet Access:** EC2 instances in the private subnets fetch software updates and necessary packages securely through a NAT Gateway deployed in the public subnet.
* **Dynamic Scalability:** The ASG uses a Target Tracking Scaling Policy based on Average CPU Utilization, allowing the infrastructure to scale out during traffic spikes and scale in during off-peak hours to optimize costs.

##  Deployment Workflow
1. Provision the foundational Virtual Private Cloud (VPC) with a 3-tier architecture (Public, App-Private, DB-Private).
2. Establish secure routing using Internet and NAT Gateways.
3. Configure Security Groups and NACLs.
4. Launch the Multi-AZ RDS database instance.
5. Create an IAM Instance Profile granting `AmazonSSMManagedInstanceCore` permissions.
6. Configure the EC2 Launch Template with the necessary Application bootstrap scripts (User Data).
7. Deploy the Application Load Balancer and configure listener rules.
8. Attach the Auto Scaling Group to the ALB Target Group.
9. Deploy AWS WAF and associate it with the ALB.
10. Set up CloudFront and Route 53 alias records.
11. Establish CloudWatch Alarms and SNS topics for real-time infrastructure monitoring.

##  Learning Outcomes Demonstrated
- Designing resilient, multi-AZ networking architectures.
- Implementing Layer 7 routing and dynamic auto-scaling policies.
- Securing cloud environments against external threats and adopting modern access methods (SSM vs. Bastion Hosts).# Scalable-Web-Application-with-ALB-and-Auto-Scaling
Achieve high availability and scalability with ALB, ASG, and a CloudFront distribution for caching static assets
