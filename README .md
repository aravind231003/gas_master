#FLUX.1 Kontext


##Introduction:
[FLUX.1 Kontext](https://huggingface.co/black-forest-labs/FLUX.1-Kontext-dev-onnx) is Black Forest Labs’ in‑context image generation and editing family that unifies text‑to‑image and image‑guided editing in a single rectified‑flow transformer. It takes text + image inputs, performs local or global edits, preserves character/style consistency, and supports iterative, multi‑turn workflows at interactive speeds.It is a 12 billion parameter rectified flow transformer capable of editing images based on text instructions. 




##Details
The architecture is described in the paper [Scaling Rectified Flow Transformers for High-Resolution Image Synthesis](https://arxiv.org/abs/2403.03206).

The model consists of two different text encoders together with their tokenizers (CLIP-L and T5-XXL), a scheduler, a transformer, and a VAE. The core component is the transformer, called Flux DiT (Diffusion Transformer). The transformer is made up of spatial, prompt and time embeddings, and a series of transformer blocks. Transformer blocks contain attention layers that operate either on the spatial embedding only, or on the spatial and prompt embeddings together.

Unlike traditional diffusion models, Flux uses learned guidance embeddings rather than classifier-free guidance (CFG). This means the model doesn't require running conditional and unconditional paths separately.

## Performance
- **FLUX.1 Kontext [dev]** — open weights, ~12B rectified‑flow transformer for text‑guided editing & generation (non‑commercial license).
- **FLUX.1 Kontext [pro]** — production model focused on fast, iterative editing and strong prompt adherence.
- **FLUX.1 Kontext [max]** — premium model with improved prompt adherence and typography handling.

## Prerequisites
- Cloned [tt-metal repository](https://github.com/tenstorrent/tt-metal) for source code
- Installed: [TT-Metalium™ / TT-NN™](https://github.com/tenstorrent/tt-metal/blob/main/INSTALLING.md)

## How to Run




## Scalability

