# close FXServer
tmux kill-session -t fxserver

# clear log file
> CitizenFX.log

# run any setup needed before checking out this file
sh setup.sh

# pull from GH repo
git checkout .
git pull

# avoid scrambling node_modules within resources
cp -r resources/[system]/[builders] .
cp -r resources/ws_server/node_modules .
rm -f -r resources/[system]/[builders]
rm -f -r resources/ws_server/node_modules

# scramble resources
java -jar ResourceEventScrambler.jar

# move node_modules back into place
mv [builders] resources/[system]
mv node_modules resources/ws_server

# run server
tmux new -d -s fxserver "bash /home/ubuntu/FXServer/server/run.sh +exec server.cfg > CitizenFX.log"
