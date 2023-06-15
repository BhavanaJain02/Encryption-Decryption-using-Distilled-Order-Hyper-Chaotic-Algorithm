classdef Senderr < matlab.apps.AppBase


% Properties that correspond to app components 
properties (Access = public)
UIFigure	matlab.ui.Figure 
SendButton	matlab.ui.control.Button 
Image	matlab.ui.control.Image 
EncryptButton matlab.ui.control.Button
end


% Callbacks that handle component events
methods (Access = private)
% Image clicked function: Image 
function ImageClicked(app, event)
global U;
U=uigetfile('.jpg','Select Image to Encrypt');
app.Image.ImageSource=U;
end


% Button pushed function: EncryptButton 
function EncryptButtonPushed(app, event)
global U;
% U=Encryption(U); 
app.Image.ImageSource="Encrypted1.png";
end


% Button pushed function: SendButton 
function SendButtonPushed(app, event)
f = msgbox("The Encrypted Image is Sent Successfully","Result");
end
end


% Component initialization
methods (Access = private)
% Create UIFigure and components 
function createComponents(app)

 
% Create UIFigure and hide until all components are created

app.UIFigure = uifigure('Visible', 'off'); 
app.UIFigure.Position = [100 100 640 480];
app.UIFigure.Name = 'MATLAB App';
 


% Create EncryptButton
app.EncryptButton = uibutton(app.UIFigure, 'push'); 
app.EncryptButton.ButtonPushedFcn =createCallbackFcn(app, @EncryptButtonPushed, true);
app.EncryptButton.Position = [449 252 100 22];
app.EncryptButton.Text = 'Encrypt';


% Create Image
app.Image = uiimage(app.UIFigure);
app.Image.ImageClickedFcn = createCallbackFcn(app, @ImageClicked, true);
app.Image.Position = [41 105 330 316];


% Create SendButton
app.SendButton = uibutton(app.UIFigure, 'push');
app.SendButton.ButtonPushedFcn = createCallbackFcn(app, @SendButtonPushed, true);
app.SendButton.Position = [271 33 100 22];
app.SendButton.Text = 'Send';


% Show the figure after all components are created 
app.UIFigure.Visible = 'on';
end 
end


% App creation and deletion 
methods (Access = public)


% Construct app 
function app = Senderr


% Create UIFigure and components 
createComponents(app)


% Register the app with App Designer 
registerApp(app, app.UIFigure)


if nargout == 0 
    clear app
end 
end


% Code that executes before app deletion 
function delete(app)


% Delete UIFigure when app is deleted 
delete(app.UIFigure)
end 
end 
end
