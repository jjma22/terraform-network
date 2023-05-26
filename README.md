Finish over weekend but basic instruction notes:
Init and apply state creation - then leave alone! for users this should already be running, do not do destroy, can leave it alone
Users only needs to:
?? go into state creation - run apply to get outputs to put into infrastucutre providers??

go into infrastucure directory
In user-data.sh, change valuess for git username, directoy, access token
make sure line 6 cd into ther directory where your index.html file is stored
save changes and inside the infrastructure directory run init and apply