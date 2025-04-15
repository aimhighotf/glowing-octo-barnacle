from kivy.uix.boxlayout import BoxLayout
from kivy.animation import Animation

class RobotSplash(BoxLayout):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.start_animation()

    def start_animation(self):
        anim = Animation(opacity=1, duration=1.5)
        anim.start(self.ids.robot_img)