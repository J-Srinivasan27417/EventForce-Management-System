# EventForce Management System
Salesforce team project for managing events, clients, vendors, venues and feedback, built in a dedicated Trailhead Playground.

**Team:** SWUID-2026-379743 — Srinivasan J, Harish V and Subikshan C  
**College:** KSK College of Engineering and Technology (8210)  
**Documentation updated:** 5 October 2026

## Project documentation

- [Project report](Project%20Document/EventForce_Project_Report.pdf): updated 66-page report with original design diagrams, nine fresh screenshots from our EventForce app, implementation details and testing evidence. The appendix ends with THANK YOU; source listings are excluded.
- [Phase-wise documents](Phase-wise%20Documents): all five PDFs updated on 5 October 2026 to align with the main report.
- [Code files](Code%20Files): available Apex classes, tests, trigger, field metadata and fictional sample CSVs.

### Five project phases

1. [Requirement Analysis and Planning](Phase-wise%20Documents/01_Requirement_Analysis_and_Planning.pdf)
2. [Backend Development and Configurations](Phase-wise%20Documents/02_Backend_Development_and_Configurations.pdf)
3. [UI/UX Development and Customization](Phase-wise%20Documents/03_UI_UX_Development_and_Customization.pdf)
4. [Data Migration, Testing and Security](Phase-wise%20Documents/04_Data_Migration_Testing_and_Security.pdf)
5. [Deployment, Documentation and Maintenance](Phase-wise%20Documents/05_Deployment_Documentation_and_Maintenance.pdf)

## Features

Six custom objects support event planning, client and vendor records, venue allocation, vendor assignments and feedback. Automation includes venue/date booking checks, cancellation approval, client notifications, a three-day reminder and scheduled completion of past events. The EventForce Lightning app includes custom tabs, a monthly report and an operations dashboard, with profiles, roles, permission sets and sharing rules controlling access.

## Verification status

| Check | Recorded result |
| --- | --- |
| Apex regression | Six project test methods passed on 3 October 2026. |
| Cancellation | Separate approval and rejection demonstrations verified their final statuses and history. |
| Sample data migration | Six imports completed with zero failed rows. |
| Reminder timing | Scheduled-path evidence showed the required three-day offset. |
| Coordinator access | Event create/read/update/delete, Client read/edit and Feedback create/delete were verified; Vendor and Venue creation were denied. The team confirmed Feedback create/edit/delete on 5 October 2026. |
| Cancellation email receipt | Verified in Gmail Spam on 5 October 2026: "Cancellation request: DEMO - Cancellation Approval Test", received 2 October 2026 at 9:50 PM. Reminder delivery separately passed based on team confirmation: email received 5 October for an 8 October 2026 event. |
| Event Admin access | Full permissions for all six custom objects were inspected. Vendor create/edit/delete passed, confirmed by the team on 5 October 2026. |
| Vendor Manager access | Vendor create/edit/delete allowed and Event changes restricted: passed, team-confirmed 5 October 2026. |
| Client access | Shared Event readable without edit/delete; unshared Event denied: passed, team-confirmed 5 October 2026. |
| Access-test scope | The four defined manual access tests passed according to the team. This is not an exhaustive audit of every object, field, or sharing scenario. |

Saved configuration and successful automation execution do not by themselves prove email receipt or complete user access coverage. No production load benchmark is claimed.

## Demo video

[Watch the completed EventForce demo video on Google Drive](https://drive.google.com/file/d/1XZxMHhKCJEvTVbzeFoLkxVYzT9PsOq8m/view?usp=sharing)

The team confirmed that the demo video is completed and uploaded.

## Submission status

The team confirmed that SkillWallet submission is complete. The five-test acceptance checklist is complete based on the recorded observations and team-confirmed results above.

## Deployment and source scope

The project is implemented in the dedicated Event Force Management System Playground; no production deployment is claimed. The source folder is a partial snapshot, not a complete deployable org export. Flows, approvals, security configuration, reports, dashboards and custom-object definitions still require retrieval from the org for a reproducible clean-org deployment.

## Guide-specific behavior

The daily batch completes past events whose status is not Completed, including Canceled and Rejected records, following the supplied guide's rule. The report documents this behavior explicitly.

  
  
