FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libc6-dev \
    libgdiplus \
    libx11-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
COPY /app/ /app/
WORKDIR /app

ENV ASPNETCORE_URLS=http://+:80
ENV Kestrel__Endpoints__Http__Url=http://0.0.0.0:80
ENV Kestrel__Endpoints__Https__Url=http://0.0.0.0:443

ENV AIService__Type=AzureOpenAI
ENV AIService__Endpoint=[AZURE_OPENAI_ENDPOINT]
ENV AIService__Key=[AZURE_OPENAI_ENDPOINT_KEY]
ENV AIService__Models__Completion=gpt-35-turbo
ENV AIService__Models__Embedding=text-embedding-ada-002
ENV AIService__Models__Planner=gpt-35-turbo

ENV Prompts__SystemDescription="This is a chat between an intelligent AI bot named Copilot and one or more participants. SK stands for Semantic Kernel, the AI platform used to build the bot. The AI was trained on data through 2021 and is not aware of events that have occurred since then. It also has no ability to access data on the Internet, so it should not claim that it can or say that it will go and look things up. Try to be concise with your answers, though it is not required. Knowledge cutoff: {{$knowledgeCutoff}} / Current date: {{TimeSkill.Now}}."
ENV Prompts__SystemResponse="Either return [silence] or provide a response to the last message. If you provide a response do not provide a list of possible responses or completions, just a single response. ONLY PROVIDE A RESPONSE IF the last message WAS ADDRESSED TO THE 'BOT' OR 'COPILOT'. If it appears the last message was not for you, send [silence] as the bot response."
ENV Prompts__InitialBotMessage="Hello, I am Chat Copilot. How can I help you today?"

ENTRYPOINT ["dotnet", "CopilotChatWebApi.dll"]
EXPOSE 80
EXPOSE 443
