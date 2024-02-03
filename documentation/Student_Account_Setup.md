# Student Account Setup and VM Deployment on Jetstream

## Getting Started with ACCESS Account
Before you begin, ensure you have an ACCESS account. Register at [ACCESS New User Registration](https://operations.access-ci.org/identity/new-user). Prompt registration is needed as account activation may take 24-48 hours.
During registration, list your university as your organization. This helps in organization-specific allocations and support.

## Introduction to Jetstream and Exosphere
- Why Exosphere? Jetstream provides multiple access methods, but we recommend Exosphere for its user-friendliness. 
- Once your ACCESS account is active, inform your professor. They need to add you to the class allocation on Jetstream. 
- *Professors:* Go into the Jetstream Exosphere web console and manually add the student via their ACCESS user name. 
- Once students are added to the allocation, it can take 24 hours before they get access to the allocation. If students have not received access after that time, reach out to Jetstream Support.

## Accessing Exosphere
Use Exosphere via your web browser. Visit [Exosphere](https://jetstream2.exosphere.app/). For detailed information, refer to the [Exosphere Documentation](https://docs.jetstream-cloud.org/ui/exo/exo/).

## Key Features of Exosphere
- Browser-based web shell (terminal).
- Optional one-click desktop environment for graphical applications.
- Browser-based file management (upload/download).
- Resource usage monitoring.
- Simplified SSH access with passphrase.

## Logging into Exosphere and Instance Setup
- Go to [Exosphere Login](https://jetstream2.exosphere.app/). 
- For login assistance, see the [Exosphere Login Guide](https://docs.jetstream-cloud.org/ui/exo/login/).
- Click “Add Allocation” and then “Add ACCESS Account”. Choose ACCESS CI (XSEDE) as your identity provider and log in with your ACCESS account.
- If your professor hasn’t pre-allocated resources, create your instance following these steps: [Create Instance Guide](https://docs.jetstream-cloud.org/ui/exo/create_instance/).
- Choose 'By Type' under instance source, and select the latest Ubuntu version.
    - Name the instance in the format: YOURNAME_CLASSCRN_YEAR (e.g., PIEPER_CS333_2024).
    - Opt for the smallest instance flavor to conserve resources, unless otherwise instructed.
    - Avoid enabling the Web Desktop option; it consumes extra resources. Use VIM for a hands-on learning experience.

## Setting Up SSH Access
- Decide between Public Key SSH or passphrase authentication (default in Exosphere). Passphrase authentication is the easiest and most straightforward method. If you do not have a lot of experience with SSH, select passphrase.
- For Public Key setup, consult the [Public Key Guide](https://kb.iu.edu/d/aews).
If using the default passphrase, note it down securely when the instance is created. Losing it means you will be **UNABLE** to get back into your instance. 
- Best practice is noting down your passphrase somewhere secure (like a password manager), and keeping copies of all important files either on your local machine or in a version control software like GitHub.

## Accessing Your Exosphere Instance
You can find the docs here for access [Access Instance Guide](https://docs.jetstream-cloud.org/ui/exo/access-instance/).
Choose between using the passphrase or a public key for SSH access, as per your earlier decision.
For either, open a terminal on your local machine.
For SSH Passphrase Authentication:
- To connect to the instance execute in your terminal `ssh exouser@<PUBLIC_IP>` where the `<PUBLIC_IP>` is the instance’s public IP address.
- When prompted, enter the exouser passphrase that was generated when you created the instance.
For Public Key Authentication:
- If you added one to the instance during creation, run the following command in the terminal: `ssh -i /path/to/key/file exouser@<PUBLIC_IP>`.
- Adding a public key manually:
    - Log into the instance using passphrase authentication.
    - Open up the file `/home/exouser/.ssh/authorized_keys` in the editor of your choice, for example: `vim /home/exouser/.ssh/authorized_keys`.
    - Paste in the key.
    - Save and close the file.

## Final Notes
This guide aims to streamline your initial setup and instance deployment on Jetstream2 using Exosphere. Should you encounter any difficulties or need further clarification, do not hesitate to reach out to your instructor or the Jetstream support team. Happy computing!
