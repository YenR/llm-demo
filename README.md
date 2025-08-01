# Godot + LMStudio Fortune Cookie Demo

A minimal Godot 4.4.1 "stub" project that shows how to call a locally-running LLM (via LM Studio) to fetch and display random "fortune cookie" wisdom. Use this as a base for your own Godot + LLM experiments!

## Prerequisites

1. **Godot 4.4.1**  (download at https://godotengine.org/)
2. **LM Studio** (download & install from [https://lmstudio.ai](https://lmstudio.ai))  
3. A downloaded model in LM Studio (e.g. gemma-3-4b)
   - Open LM Studio’s **Discover** tab, find your model (e.g. Gemma 3 4B), click **Download**
   - In the **Developer** tab, select the model and click **Start Server**  
   - Note the generated URL (default: `http://127.0.0.1:1234/v1/completions`)

## How to run

1. Download source, e.g. with `git clone https://github.com/YenR/llm-demo.git`
2. Start LLM Server (see above)
3. Start Godot 
4. Import source folder (or drag and drop into project browser) 
5. Select project and click "Edit"
6. Open file `main.gd` and edit `model_name` and `url`