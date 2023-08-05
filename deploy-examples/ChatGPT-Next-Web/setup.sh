# install git python3.10 yarn by yourself
# change model and strategy according to your hardware

sudo apt-get -y install python-dev

# mkdir RWKV-Next-Web
# cd RWKV-Next-Web

# git clone https://github.com/josStorer/RWKV-Runner --depth=1
python -m pip install torch torchvision torchaudio
python -m pip install -r /kaggle/working/RWKV-Runner/backend-python/requirements.txt
python /kaggle/working/RWKV-Runner/backend-python/main.py > log.txt &

if [ ! -d /kaggle/working/RWKV-Runner/models ]; then
    mkdir /kaggle/working/RWKV-Runner/models
fi
wget -N https://huggingface.co/BlinkDL/rwkv-4-world/resolve/main/RWKV-4-World-0.1B-v1-20230520-ctx4096.pth -P /kaggle/working/RWKV-Runner/models/

git clone https://github.com/Yidadaa/ChatGPT-Next-Web --depth=1
cd /kaggle/working/ChatGPT-Next-Web
yarn install
yarn build
export PROXY_URL=""
export BASE_URL=http://127.0.0.1:8000
yarn start &

curl http://127.0.0.1:8000/switch-model -X POST -H "Content-Type: application/json" -d '{"model":"/kaggle/working/RWKV-Runner/models/RWKV-4-World-0.1B-v1-20230520-ctx4096.pth","strategy":"cpu fp32"}'
