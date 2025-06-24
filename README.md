**Azure Secure Infrastructure – Freelance Client Deployment (2025)**

> 💼 This engagement was part of a freelance assignment for a startup client seeking to improve its cloud security posture during early production rollout. The goal was to build and test foundational infrastructure aligned with real-world operational needs.
This project involved designing and deploying a secure, production-style Azure environment for a client. The scope included identity controls via Microsoft Entra, hardened access policies (JIT, Bastion), multi-tier networking, log analytics via Sentinel, and routing traffic through an Application Gateway.

**Overview:**
Designed and deployed a robust, production-grade Azure infrastructure for an SME client, emphasizing security, automation, and real-world operational best practices.

**🔑 Core Deliverables & Security Controls**
**Identity & Access:**
Microsoft Entra ID setup with P1 licensing
User provisioning, Conditional Access, and RBAC via Admin Units
MFA enforcement and custom login restrictions

**Compute & Web Tier:**
Ubuntu VM deployed with hardened NSG rules and JIT enabled
NGINX web server deployed and tested
Public IP access restricted based on business rules

**Network Architecture:**
Two VNets with unique CIDRs, peered for private connectivity
Subnetting best practices: Dedicated subnets for VMs, App Gateway, and Bastion
All VM-to-VM communication and SSH tunneled privately

**Bastion & App Gateway:**
Azure Bastion deployed for secure, browser-based RDP/SSH (no public IP exposure)
Application Gateway routes traffic with custom path-based rules to backend VMs

**Monitoring & Automation:**
Defender for Cloud with custom alert rules
Microsoft Sentinel as SIEM, integrated with Logic App for automated incident email notifications
Converted key infra (VMs, Peering, App Gateway) into reusable Bicep templates to enable repeatable and auditable deployment. CLI used for quota override and script-based provisioning.

**🧠 Key Lessons & Real-World Insights**
**Quota Exhaustion Bypass:**
CLI can sometimes provision resources even when Portal enforces quota limits.

**VNet Peering:**
Unique CIDR blocks required; overlapping addresses break peering.

**App Gateway Deployment:**
Must use a dedicated subnet—cannot share with VMs.

**Secure Access:**
Bastion is essential for VMs without public IPs; enables secure, just-in-time SSH/RDP.

**JIT NSG Rules:**
Remove pre-existing open port 22 rules for Defender JIT to function.

**Sentinel vs Logic App:**
Sentinel is a full SIEM, while Logic App automates incident responses.

**✅ Client Outcomes**
Secure, segmented cloud environment (zero trust by default)
Automated alerts and incident response
Future-proofed with infrastructure as code
User and access controls tailored to real business needs

**This project demonstrates:**
End-to-end cloud security design
Practical Azure deployment expertise
Focus on operational excellence and automation
