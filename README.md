# Get Role Assignments in Azure

This repository provides scripts to get standing access RBAC assignements and eligible assignments within Privileged Identity Management (PIM).

## Getting Started

There are 4 scripts in this repo:

- [List of Standing RBAC Access on Subscriptions](./getStandingRBACAssignmentsSubscriptions.ps1)
- [List of Standing RBAC Access on Management Groups](./getStandingRBACAssignmentsManagementGroups.ps1)
- [List of Azure AD Assigned Administrator Roles](./getStandingADRoleAssignments.ps1)
- [List of PIM Eligible RBAC Assignments](./getPIMAssignmentInfo.ps1)

### List of Standing RBAC Access on Subscriptions

To run this script, simply navigate to [Azure Cloud Shell](https://shell.azure.com) and clone this repo: `git clone https://github.com/grtn316/GetAzureAssignments.git`

Once the repo has been cloned, step into the directory and run the script:
```powershell
cd GetAzureAssignments
./getStandingRBACAssignmentsSubscriptions.ps1
```

Once the script has finished iterating through all of the assignments across subscriptions, you will find a file called `StandingRBACAssignmentsSubscriptions-YYYY-MM-DD.csv` in the directory.

### List of Standing RBAC Access on Management Groups

To run this script, simply navigate to [Azure Cloud Shell](https://shell.azure.com) and clone this repo: `git clone https://github.com/grtn316/GetAzureAssignments.git`

Once the repo has been cloned, step into the directory and run the script:
```powershell
cd GetAzureAssignments
./getStandingRBACAssignmentsManagementGroups.ps1
```

Once the script has finished iterating through all of the assignments across subscriptions, you will find a file called `StandingRBACAssignmentsManagementGroups-YYYY-MM-DD.csv` in the directory.

### List of Azure AD Assigned Administrator Roles

To run this script, simply navigate to [Azure Cloud Shell](https://shell.azure.com) and clone this repo: `git clone https://github.com/grtn316/GetAzureAssignments.git`

Once the repo has been cloned, step into the directory and run the script:
```powershell
cd GetAzureAssignments
./getStandingADRoleAssignments.ps1
```

Once the script has finished iterating through all of the assignments across subscriptions, you will find a file called `StandingADRoleAssignments-YYYY-MM-DD.csv` in the directory.

### List of PIM Eligible RBAC Assignments

To run this script, simply navigate to [Azure Cloud Shell](https://shell.azure.com) and clone this repo: `git clone https://github.com/grtn316/GetAzureAssignments.git`

Once the repo has been cloned, step into the directory and run the script:
```powershell
cd GetAzureAssignments
./getPIMAssignmentInfo.ps1 -SubscriptionId <SubscriptionId>
```

Once the script has finished iterating through all of the PIM assignments in the provided subscription, you will find a file called `PIMAssignmentInfo_<SubscriptionID>_YYYY-MM-DD.csv` in the directory.