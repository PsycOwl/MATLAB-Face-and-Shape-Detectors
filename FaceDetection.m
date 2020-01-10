function varargout = FaceDetection(varargin)

% ------------------ARAY�Z BA?LANTILARI----------------------
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FaceDetection_OpeningFcn, ...
                   'gui_OutputFcn',  @FaceDetection_OutputFcn, ...
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
% ------------------ARAY�Z BA?LANTILARI SONU------------------

% ARAY�Z �IKMADAN �NCE KO?AN KOD
function FaceDetection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    Aray�z� nesnesi
% handles    Kullan?c? ile ilgili datalar?n tutuldu?u s?n?f
% varargin   Komut sat?r? arg�man?

% �?kt? i�in varsay?lan komut sat?r?
handles.output = hObject;
handles.img = 0;
% handles yap?s?n? g�ncelle
guidata(hObject, handles);


% Bu fonksiyonun �?kt?s? komut sat?r?na d�ner
function varargout = FaceDetection_OutputFcn(hObject, eventdata, handles) 
% varargout  Geri d�nen �?kt? parametreleri

% handles ile �?kan varsay?lan �?kt? parametreleri
varargout{1} = handles.output;

% 'Alg?la' butonuna bas?l?nca �al??acak olan kod
function FaceDetection_Callback(hObject, eventdata, handles)

if(handles.img == 0)
    return;
end
faceDetector = vision.CascadeObjectDetector();
% handles.img deki y�zleri alg?l?yor
bbox= step(faceDetector,handles.img);
% y�zlerin etraf?na d�rtgen �iziyor
handles.img = insertShape(handles.img, 'Rectangle', bbox);
imshow(handles.img);% Resmi g�steriyor 
guidata(hObject, handles);%Veri g�ncellemesi

% 'A�' butonuna t?klay?nca �al??acak olan kod
function OpenImage_Callback(hObject, eventdata, handles)

[filename, pathname] = uigetfile('*.jpg', 'Select a jpg image'); % Resim se�
if ~isequal(filename,0)   
   pathfile=fullfile(pathname, filename);  % Resim yoluna ula?
   handles.img = imread(pathfile);     % 'pathfile' da bulunan resmi oku
   imshow(handles.img);% Resmi g�ster 
   guidata(hObject, handles);% Veri g�ncellemesi
end

% 'Temizle' butonuna t?klay?nca �al??acak kod
function ClearImage_Callback(hObject, eventdata, handles)

cla
handles.img = 0;
guidata(hObject, handles);
