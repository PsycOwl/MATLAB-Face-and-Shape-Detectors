function varargout = FaceDetection(varargin)

% ------------------ARAYÜZ BA?LANTILARI----------------------
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
% ------------------ARAYÜZ BA?LANTILARI SONU------------------

% ARAYÜZ ÇIKMADAN ÖNCE KO?AN KOD
function FaceDetection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    Arayüzü nesnesi
% handles    Kullan?c? ile ilgili datalar?n tutuldu?u s?n?f
% varargin   Komut sat?r? argüman?

% Ç?kt? için varsay?lan komut sat?r?
handles.output = hObject;
handles.img = 0;
% handles yap?s?n? güncelle
guidata(hObject, handles);


% Bu fonksiyonun ç?kt?s? komut sat?r?na döner
function varargout = FaceDetection_OutputFcn(hObject, eventdata, handles) 
% varargout  Geri dönen ç?kt? parametreleri

% handles ile ç?kan varsay?lan ç?kt? parametreleri
varargout{1} = handles.output;

% 'Alg?la' butonuna bas?l?nca çal??acak olan kod
function FaceDetection_Callback(hObject, eventdata, handles)

if(handles.img == 0)
    return;
end
faceDetector = vision.CascadeObjectDetector();
% handles.img deki yüzleri alg?l?yor
bbox= step(faceDetector,handles.img);
% yüzlerin etraf?na dörtgen çiziyor
handles.img = insertShape(handles.img, 'Rectangle', bbox);
imshow(handles.img);% Resmi gösteriyor 
guidata(hObject, handles);%Veri güncellemesi

% 'Aç' butonuna t?klay?nca çal??acak olan kod
function OpenImage_Callback(hObject, eventdata, handles)

[filename, pathname] = uigetfile('*.jpg', 'Select a jpg image'); % Resim seç
if ~isequal(filename,0)   
   pathfile=fullfile(pathname, filename);  % Resim yoluna ula?
   handles.img = imread(pathfile);     % 'pathfile' da bulunan resmi oku
   imshow(handles.img);% Resmi göster 
   guidata(hObject, handles);% Veri güncellemesi
end

% 'Temizle' butonuna t?klay?nca çal??acak kod
function ClearImage_Callback(hObject, eventdata, handles)

cla
handles.img = 0;
guidata(hObject, handles);
