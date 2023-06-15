classdef Receiver < matlab.apps.AppBase


% Properties that correspond to app components 
properties (Access = public)
UIFigure matlab.ui.Figure
ReceiveButton matlab.ui.control.Button
Image matlab.ui.control.Image 
DecryptButton matlab.ui.control.Button 
end


% Callbacks that handle component events 
methods (Access = private)
% Image clicked function: Image 
function ImageClicked(app, event) 
end



% Button pushed function: DecryptButton 
function DecryptButtonPushed(app, event)
global U;
% U=Encryption(U); 
app.Image.ImageSource="Output1.png";
end

% Button pushed function: ReceiveButton 
function ReceiveButtonPushed(app, event) 
    app.Image.ImageSource="Encrypted1.png";
f = msgbox("The Encrypted Image is Received Successfully","Result");
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


% Create DecryptButton
app.DecryptButton = uibutton(app.UIFigure, 'push');
app.DecryptButton.ButtonPushedFcn = createCallbackFcn(app, @DecryptButtonPushed, true); 
app.DecryptButton.Position = [449 252 100 22];
app.DecryptButton.Text = 'Decrypt';


% Create Image
app.Image = uiimage(app.UIFigure); app.Image.ImageClickedFcn = createCallbackFcn(app, @ImageClicked, true);
app.Image.Position = [41 105 330 316];


% Create ReceiveButton
app.ReceiveButton = uibutton(app.UIFigure, 'push'); 
app.ReceiveButton.ButtonPushedFcn = createCallbackFcn(app, @ReceiveButtonPushed, true);
app.ReceiveButton.Position = [271 33 100 22];
app.ReceiveButton.Text = 'Receive';

 
% Show the figure after all components are created 
app.UIFigure.Visible = 'on';
 
end
end

% App creation and deletion
methods (Access = public)

% Construct app 
function app = Receiverr

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
