from agno.agent import Agent
from agno.app.fastapi.app import FastAPIApp
from agno.app.fastapi.serve import serve_fastapi_app
from agno.models.openrouter import OpenRouter

basic_agent = Agent(
    name="Basic Agent",
    model=OpenRouter(id="google/gemini-2.5-flash-preview-05-20"), 
    add_history_to_messages=True,
    num_history_responses=3,
    add_datetime_to_instructions=True,
    markdown=True,
)

def create_app():
    app: FastAPIApp = FastAPIApp(agent=basic_agent).get_app()


# Async router by default (use_async=True)
app = create_app()

# For synchronous router:
# app = FastAPIApp(agent=basic_agent).get_app(use_async=False)

if __name__ == "__main__":
    # Assumes script is `basic_app.py`; update if different.
    serve_fastapi_app("main:app", port=8001, reload=True)