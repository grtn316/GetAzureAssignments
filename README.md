# Get Role Assignments in Azure

This repository provides scripts to get standing access RBAC assignements and eligible assignments within Privileged Identity Management (PIM).

## Getting Started

There are 4 scripts in this repo:

- [List of Standing RBAC Access on Subscriptions](./getStandingRBACAssignmentsSubscriptions.ps1)
- [List of Standing RBAC Access on Management Groups](./getStandingRBACAssignmentsManagementGroups.ps1)
- [List of Azure AD Assigned Administrator Roles](./getStandingADRoleAssignments.ps1)
- [List of Eligible RBAC Assignments]()

### List of Standing RBAC Access on Subscriptions

To run this script, simply navigate to [Azure Cloud Shell](https://shell.azure.com) and clone this repo: `git clone https://github.com/grtn316/GetAzureAssignments.git`

Once the repo has been cloned, step into the directory and run the script:
```powershell
cd GetAzureAssignments
./getStandingRBACAccess.ps1
```

Once the script has finished iterating through all of the assignments across subscriptions, you will find a file called `StandingRBACAssignmentsSubscriptions-YYYY-MM-DD.csv` in the directory.

### List of Standing RBAC Access on Management Groups

To run this script, simply navigate to [Azure Cloud Shell](https://shell.azure.com) and clone this repo: `git clone https://github.com/grtn316/GetAzureAssignments.git`

Once the repo has been cloned, step into the directory and run the script:
```powershell
cd GetAzureAssignments
./getStandingRBACManagementGroupAccess.ps1
```

Once the script has finished iterating through all of the assignments across subscriptions, you will find a file called `StandingRBACAssignmentsManagementGroups-YYYY-MM-DD.csv` in the directory.

### List of Azure AD Assigned Administrator Roles

To run this script, simply navigate to [Azure Cloud Shell](https://shell.azure.com) and clone this repo: `git clone https://github.com/grtn316/GetAzureAssignments.git`

Once the repo has been cloned, step into the directory and run the script:
```powershell
cd GetAzureAssignments
./getStandingAzureADRoleAccess.ps1
```

Once the script has finished iterating through all of the assignments across subscriptions, you will find a file called `StandingADRoleAssignments-YYYY-MM-DD.csv` in the directory.

### List of Eligible RBAC Assignments
Coming Soon...