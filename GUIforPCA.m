function varargout = GUIforPCA(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUIforPCA_OpeningFcn, ...
                   'gui_OutputFcn',  @GUIforPCA_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function GUIforPCA_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUIforPCA (see VARARGIN)

% Choose default command line output for GUIforPCA
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

function varargout = GUIforPCA_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function Close_Callback(hObject, eventdata, handles)

close all;


function SelectImage_Callback(hObject, eventdata, handles)

path = 'test_images\*';
selectedFile = uigetfile(fullfile(path ));
axes(handles.TestImage);

  ImgName = char(strcat('test_images\',selectedFile));
  Q=ImgName;
  H=imread(ImgName,'jpg');
 
imshow(H);
%reading training images and assigning a label to each training image
training_images=dir('train_images\*.jpg');
Lt=[];
T=[];

for k = 1 : length(training_images)
    
 ImgName = training_images(k).name;
  Lt=[Lt ; ImgName(:,1:3)];
  ImgName = char(strcat('train_images\',ImgName(1:end-4)));

 GRAYIm = imread(ImgName, 'jpg');
 Img=reshape(GRAYIm,1,64*64);
 T=[T ; Img]; 
end

%subtract off the mean for each dimension
mT=mean(T,2);%mean of rows
D=double(T)-repmat(mT,1,size(T,2));

%covariance matrix
sigma=(1/(length(training_images)-1))*D*(D');


%eigenvalues and eigenvectors
[V,DD]=eigs(sigma,length(training_images)-2);

phay=D'*V;

Ft=[];
for k = 1 : length(training_images)
                                    
 ImgName = training_images(k).name;
  ImgName = char(strcat('train_images\',ImgName(1:end-4)));
 GRAYIm = imread(ImgName, 'jpg');
 Img=reshape(GRAYIm,1,64*64);
 recon=double(Img)*phay;
 Ft=[Ft;recon];
end

 H=reshape(H,1,64*64);
 rec=double(H)*phay; 
 
 

for k=1:length(training_images)
    x(k)=norm(rec-Ft(k,:));
end

[a z]=min(x);
[b g]=sort(x);
z;
Lt(z,1:end); 
g(2);
 Lt(g(2),1:end);
g(3);
 Lt(g(3),1:end);


if Lt(z,1:end)~=Q(:,13:15)

set(handles.ResultM,'string','Not Match');
elseif Lt(z,1:end)==Q(:,13:15)

set(handles.ResultM,'string','Match');
end

axes(handles.axes3);
MatchedImage=T(g(1),:);
MatchedImage=reshape(MatchedImage,64,64);
imshow(MatchedImage);
MatchedImage=reshape(MatchedImage,64,64);
axes(handles.axes4);
MatchedImage=T(g(2),:);
MatchedImage=reshape(MatchedImage,64,64);
imshow(MatchedImage);
axes(handles.axes5);
MatchedImage=T(g(3),:);
MatchedImage=reshape(MatchedImage,64,64);
imshow(MatchedImage);


function edit5_Callback(hObject, eventdata, handles)

function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit6_Callback(hObject, eventdata, handles)

function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit7_Callback(hObject, eventdata, handles)

function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function accuracyResult_Callback(hObject, eventdata, handles)
% hObject    handle to accuracyResult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of accuracyResult as text
%        str2double(get(hObject,'String')) returns contents of accuracyResult as a double


% --- Executes during object creation, after setting all properties.


% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
