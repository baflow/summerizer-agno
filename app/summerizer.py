from agno.agent import Agent
from agno.app.fastapi.app import FastAPIApp
from agno.app.fastapi.serve import serve_fastapi_app
from agno.models.openrouter import OpenRouter
from pydantic import BaseModel, Field

class Summary(BaseModel):
    summary: str = Field(..., description="Transcription summary in markdown format")
    topic: str = Field(..., description="Main topic of the transcription")
    
basic_agent = Agent(
    name="Basic Agent",
    model=OpenRouter(id="google/gemini-2.5-flash-preview-05-20"), 
    add_history_to_messages=True,
    num_history_responses=3,
    add_datetime_to_instructions=True,
    markdown=True,
)

app = FastAPIApp(agent=basic_agent).get_app()

serve_fastapi_app("summerizer:app", port=8001, reload=True)