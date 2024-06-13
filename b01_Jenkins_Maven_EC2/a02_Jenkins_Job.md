<!-- First Jenkins Job  -->

*New Item* (Create a job)
*Item name*: j01_Hello_World
*SELECT*: Freestyle project
General
*Description*: Hello World
Source Code Management
Build Triggers
Build Steps
*Add build step*
*Execute shell*
Command: 
echo *“Hello World”*
*uptime*
Post-build Actions
*Apply and save*
*