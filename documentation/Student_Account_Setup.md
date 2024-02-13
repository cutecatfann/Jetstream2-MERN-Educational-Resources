# Professor Account Deployment and VM Allocations for Students on Jetstream

## Getting Started with ACCESS Account
Before you begin, ensure you have an ACCESS account. Register at [ACCESS New User Registration](https://operations.access-ci.org/identity/new-user). Prompt registration is needed as account activation may take 24-48 hours.
During registration, list your university as your organization. This helps in organization-specific allocations and support.

## Introduction to Jetstream and Exosphere
- Why Exosphere? Jetstream provides multiple access methods, but we recommend Exosphere for its user-friendliness. 

## Accessing Exosphere
Use Exosphere via your web browser. Visit [Exosphere](https://jetstream2.exosphere.app/). For detailed information, refer to the [Exosphere Documentation](https://docs.jetstream-cloud.org/ui/exo/exo/).

## Key Features of Exosphere
- Browser-based web shell (terminal).
- Optional one-click desktop environment for graphical applications.
- Browser-based file management (upload/download).
- Resource usage monitoring.
- Simplified SSH access with passphrase.

## Exosphere Instance Setup
- Go to [Exosphere Login](https://jetstream2.exosphere.app/). 
- For login assistance, see the [Exosphere Login Guide](https://docs.jetstream-cloud.org/ui/exo/login/).
- Click “Add Allocation” and then “Add ACCESS Account”. Choose ACCESS CI (XSEDE) as your identity provider and log in with your ACCESS account.
- Create instances for your students (to simplify the process for them) by following these steps: [Create Instance Guide](https://docs.jetstream-cloud.org/ui/exo/create_instance/).
- Choose 'By Type' under instance source, and select the latest Ubuntu version. NOTE: Ubuntu 20.04 works as well for all the instructions
    - Name the instance in the format: STUDENTLNAME_CLASSCRN_YEAR (e.g., PIEPER_CS333_2024).
    - Opt for the smallest instance flavor to conserve resources, unless otherwise instructed.    
        - All deployment instructions have been tested and are fully functional on an m3.tiny size, this is recommended unless your students are using very intensive resources. Bigger sizes burn many more SUs per hour, so it is important to give students the minimum size possible.
    - Avoid enabling the Web Desktop option; it consumes extra resources. Students can use VIM (preinstalled), or other options like nano.
        - For a tiny instance using Ubuntu and no web desktop option, the burn rate is 1 SU/hour, which is lower than having it enabled

## Sharing the Credentials

# Student Instructions for Accessing the Instance
## Accessing Your Exosphere Instances
You can find the docs here for access [Access Instance Guide](https://docs.jetstream-cloud.org/ui/exo/access-instance/).
Open a terminal on your local machine.
For SSH Passphrase Authentication:
- To connect to the instance execute in your terminal `ssh exouser@<PUBLIC_IP>` where the `<PUBLIC_IP>` is the instance’s public IP address. This should be provided to you by your professor.
- When prompted, enter the exouser passphrase that was generated when your professor created the instance. Your professor should have shared it with you, ensure that you don't have extra lines, spaces, or characters at the end of thre passphrase.
- If you lose the passphrase, contact your professor for help.

## Final Notes
This guide aims to streamline your initial setup and instance deployment on Jetstream2 using Exosphere. Should you encounter any difficulties or need further clarification, do not hesitate to reach out to your instructor or the Jetstream support team. Happy computing!
