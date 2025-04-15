from kivy.uix.boxlayout import BoxLayout
from kivy.uix.textinput import TextInput
from kivy.uix.scrollview import ScrollView
from kivy.properties import StringProperty
import openai
import threading

class ChatGPT4UI(BoxLayout):
    chat_history = StringProperty('')

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.api_key = "your-openai-key"  # Replace with your key

    def send_message(self, message):
        self.chat_history += f"\nYou: {message}"
        threading.Thread(target=self.get_response, args=(message,)).start()

    def get_response(self, message):
        try:
            response = openai.ChatCompletion.create(
                model="gpt-4",
                messages=[{"role": "user", "content": message}],
                api_key=self.api_key
            )
            self.chat_history += f"\nAI: {response.choices[0].message.content}"
        except Exception as e:
            self.chat_history += f"\nError: {str(e)}"