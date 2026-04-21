# llm
## local ollama on windows laptop with Intel Arc GPU
- Go to https://github.com/ollama/ollama/releases
- Download ollama-windows-amd64.zip and unzip to a folder i.e. C:\ollama-windows-amd64
- Copy start-ollama.bat form this repo to the folder C:\ollama-windows-amd64
- If you need to adjust environment variables for ollama set them in start-ollama.bat
## run ollama (open a console)
- `cd C:\ollama-windows-amd64`
- `start-ollama.bat` -> this starts the ollama server in a second console window
- In the first console you now can enter ollama commands i.e.
  - `ollama list` to show all locally available llm models
  - `ollama pull qwen2.5-coder:7b` to add this llm model to ollama
  - `ollama rm   qwen2.5-coder:7b` to remove this llm model from ollama
  - `ollama run  qwen2.5-coder:7b` to start a chat session
- LLM-Models are locally saved in the users folder: C:\Users\<yourusername>\.ollama\models
- The ollama server provides a Rest-API at http://localhost:11434 this API can be used by third parties like Claude Code or AnythingLLM
## make ollama use GPU
- Ollama is currently optimized for Mac Nivida GPU (CUDA)
- In the past one could use the IPEX‑LLM “Ollama Portable Zip” (Windows) but it's ollama v0.9.x is outdated and does not support Claude
- Currently a option is setting `OLLAMA_VULKAN=1` in start-ollama.bat to enable GPU usage in windows. But I have problems with this when trying to run Claude with Ollama. Claude currently runs only with ollama on CPU but this is very slow.
## make Claude Code use Ollama (open a console)
- set environment variables to deviate claude to local ollama
  - `set CLAUDE_CODE_ATTRIBUTION_HEADER=0`
  - `set ANTHROPIC_AUTH_TOKEN=ollama`
  - `set ANTHROPIC_BASE_URL=http://localhost:11434`
- when having trouble with 500 errors in ollama mostly heavy traffic on the vulkan drivers for GPU is the problem, may be future version of ollama or vulkan resolve the problems (one must play around with environment variables like OLLAMA_NUM_GPU, OLLAMA_NUM_PARALLEL etc.)
## make Anything-LLM use Ollama
- Anything-LLM is a UI to work with local an remote AI and to chat with documents
- To run Anything-LLM the easiest way is to use DockerDesktop
- Create a folder to persist Anything-LLM data i.e. C:\anything-llm-data
- Open a new console `docker run -d -p 3001:3001 --name anythingllm -v C:\anything-llm-data:/app/server/storage -e STORAGE_DIR="/app/server/storage" mintplexlabs/anythingllm`
- In Anything-LLM enter this http://host.docker.internal:11434 as Ollama Base URL. This allows Anything-LLM from within the container to connect to the host's http://localhost:11434 where Ollama is listening


