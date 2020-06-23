function varargout = min_project(varargin)
% MIN_PROJECT MATLAB code for min_project.fig
%      MIN_PROJECT, by itself, creates a new MIN_PROJECT or raises the existing
%      singleton*.
%
%      H = MIN_PROJECT returns the handle to a new MIN_PROJECT or the handle to
%      the existing singleton*.
%
%      MIN_PROJECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MIN_PROJECT.M with the given input arguments.
%
%      MIN_PROJECT('Property','Value',...) creates a new MIN_PROJECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before min_project_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to min_project_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help min_project

% Last Modified by GUIDE v2.5 16-Nov-2019 13:01:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @min_project_OpeningFcn, ...
                   'gui_OutputFcn',  @min_project_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before min_project is made visible.
function min_project_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to min_project (see VARARGIN)

% Choose default command line output for min_project
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes min_project wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = min_project_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%Reading Images
I1=imread('C:\Users\sammy\Documents\MP!@3\CT-MRT2\s01_CT.tif');
I2=imread('C:\Users\sammy\Documents\MP!@3\CT-MRT2\s01_MRT2.tif');
axes(handles.axes1);
imshow(I1);
axes(handles.axes2);
imshow(I2);



% Wavelet Transform 
[A1,A2,A3,A4]=dwt2(I1,'Db4');
[B1,B2,B3,B4]=dwt2(I2,'Db4');

%Bilateral Filter 
X1=imbilatfilt(A1);
X2=imbilatfilt(B1);

[m,n]=size(X1);
X3=X1;


  for i=1:m
      for j=1:n
          X3(i,j)= max(X1(i,j),X2(i,j));
      end
  end
  
  
  
  %ENTROPY  BASED FUSION
  
  X4=[3,3];  
  X5=[3,3];
 
 [m,n]=size(A2);
 X6=[m,n];
 for i=1:m-2
     for j=1:n-2
         c=1;
         for k=i:i+2
             d=1;
             for l=j:j+2
             X4(c,d)=A2(k,l);
             d=d+1;
             end
             c=c+1;
         end
         c=1;
         for k=i:i+2
             d=1;
             for l=j:j+2
             X5(c,d)=B2(k,l);
             d=d+1;
             end
             c=c+1;
         end
         if entropy(X4)>entropy(X5)
             c=1;
             for k=i:i+2
                 d=1;
                 for l=j:j+2
                     X6(k,l)=X4(c,d);
                     d=d+1;
                 end
                 c=c+1;
             end
         else
             c=1;
             for k=i:i+2
                 d=1;
                 for l=j:j+2
                     X6(k,l)=X5(c,d);
                     d=d+1;
                 end
                 c=c+1;
             end
         end
     end
 end
  X7=[3,3];
  X8=[3,3];
 
 [m,n]=size(A2);                 % SIZE DECLARATION
 X9=[m,n];                       % SIZE ASSIGNMENT
 for i=1:m-2
     for j=1:n-2
         c=1;
         for k=i:i+2
             d=1;
             for l=j:j+2
             X7(c,d)=A3(k,l);
             d=d+1;
             end
             c=c+1;
         end
         c=1;
         for k=i:i+2
             d=1;
             for l=j:j+2
             X8(c,d)=B3(k,l);
             d=d+1;
             end
             c=c+1;
         end
         if entropy(X4)>entropy(X5)              % COMPARING ENTROPY
             c=1;
             for k=i:i+2
                 d=1;
                 for l=j:j+2
                     X9(k,l)=X7(c,d);
                     d=d+1;
                 end
                 c=c+1;
             end
         else
             c=1;
             for k=i:i+2
                 d=1;
                 for l=j:j+2
                     X9(k,l)=X8(c,d);
                     d=d+1;
                 end
                 c=c+1;
             end
         end
     end
 end
  X10=[3,3]; % ALLOTING SIZE
  X11=[3,3]; % ALLOTING SIZE
 
 [m,n]=size(A2);
 X12=[m,n];
 for i=1:m-2
     for j=1:n-2
         c=1;
         for k=i:i+2
             d=1;
             for l=j:j+2
             X10(c,d)=A4(k,l);
             d=d+1;
             end
             c=c+1;
         end
         c=1;
         for k=i:i+2
             d=1;
             for l=j:j+2
             X11(c,d)=B4(k,l);
             d=d+1;
             end
             c=c+1;
         end
         if entropy(X4)>entropy(X5)
             c=1;
             for k=i:i+2
                 d=1;
                 for l=j:j+2
                     X12(k,l)=X10(c,d);
                     d=d+1;
                 end
                 c=c+1;
             end
         else
             c=1;
             for k=i:i+2
                 d=1;
                 for l=j:j+2
                     X12(k,l)=X11(c,d);
                     d=d+1;
                 end
                 c=c+1;
             end
         end
     end
 end
     
 % Inverse Wavelet Transform 
I3=idwt2(X3,X6,X9,X12,'Db4');
axes(handles.axes3);

imshow(I3,[]);
%title('First Image')
%figure,imshow(I2)
%title('Second Image')
%figure,imshow(I3,[])
%title('Fused Image')


% Performance Criteria

CR1=corr2(I1,I3);
CR2=corr2(I2,I3);
S1=ssim(double(I1),(I3));
set(handles.text2,'String',S1);
S2=ssim(double(I2),(I3));
set(handles.text3,'String',S2);
fprintf('Correlation between first image and fused image =%f \n\n',CR1);
fprintf('Correlation between second image and fused image =%f \n\n',CR2);
fprintf('SSIM between first image and fused image =%4.2f db\n\n',S1);
fprintf('SSIM between second image and fused image =%4.2f db \n\n',S2);

   
   
 
  



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double






% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end








function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end







%         VARIABLE DESCRIPTION
%  VARIABLE_ NAME              DESCRIPTION    
%  i,j,k,l                     looping variable
%  X4,X5,X7,X8,X10,X11         3*3 MATRIX LATER ON USED FOR COMPARING ENTROPY
%  X1,X2                       MATRIX TO STORE VALUES AFTER APPLYING BILATERAL
%                               FILTER.
% X3,X6,X9                     MATRIX HAVING VALUES AFTER COMPARING ENTROPY