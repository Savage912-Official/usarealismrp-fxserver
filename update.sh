# pull from GH repo
git checkout . --recurse-submodules
git pull --recurse-submodules

# init submodules if ncessary
git submodule init
git submodule update

# idk why we need to do this manually every time or if we really need to do but i guess for now whatever if it works
cd resources/[custom_maps]
git checkout master
git pull
cd ../../