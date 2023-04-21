# Reset.sh
Shell script files that download programs and change settings after resetting your 42 Mac.   
초기화 이후에 필요한 프로그램을 다운하고 설정을 변경해 주는 쉘스크립트 파일입니다.   

> **__Pull requests, and error reports are all welcomed.__** 

# Install
After reset your mac by `touch ~/.reset`, clone this repo in anywhere you want, and run `./after_reset`.  
```diff
- ⚠️ PLEASE BACKUP ALL YOUR FILES BEFORE YOU USE `touch ~/.reset` COMMAND ⚠️
```
`touch ~/.reset`으로 맥 초기화를 진행한 후에, 원하는 곳에 이 레포를 clone한 뒤에 `./after_reset`으로 파일을 실행해주세요.
```diff
- ⚠️ `touch ~/.reset` 명령어는 맥을 초기화해주는 명령어입니다. 사용하시기 전에 모든 파일을 백업해두고 사용하세요! ⚠️
```

# Features
## after_reset.sh
- [42header plugin](https://github.com/42Paris/42header)
    <!-- - After installation, it will ask your intra ID and set the header user name and mail by the input. -->
    <!-- - 플러그인 설치가 완료되면 인트라 ID를 입력받고 자동으로 헤더 이름과 메일을 설정해줍니다. -->
	- Able to set or reset your intra id. 인트라 ID 재설정 가능. (Sep 14th 2022 update)
- [42toolbox](https://github.com/alexandregv/42toolbox)
- ssh key
    - This command checks the existence of the SSH key (create it when it does not exist) and copies the public key into your clipboard. Your GitHub and 42 intra SSH key setting page will be opened automatically after that.
    - SSH key가 있는지 없는지 확인한 후에 public key를 클립보드에 복사합니다. SSH key를 등록하는 GitHub 페이지와 42 인트라 페이지가 자동을 뜹니다.
- run vscode in terminal
    - By just typing `code .` in terminal, you can open your pwd folder in vscode.
    - `code .` 이라는 명령어를 치면 pwd 폴더를 vscode로 열 수 있습니다.
- [oh_my_zsh](https://ohmyz.sh/)
    - Install oh_my_zsh. oh_my_zsh will be applied in your terminal after you finish setting 42_reset_sh.
    - oh_my_zsh를 설치해줍니다. 42_reset_sh가 종료되면 oh_my_zsh가 터미널에 적용될 것입니다.
- [42brew](https://github.com/Homebrew/brew)
    - Install brew if you need it. If you don't, you cannot change your dock setting by this shell script.
    - brew를 설치할 건지 물어봅니다. brew를 설치하지 않으면 dock 설정을 변경할 수 없습니다.
- `tree` (brew install tree)
    - `tree` is a recursive directory listing command that produces a depth-indented listing of files. If you want to use it, you need to install brew.
    - `tree`는 파일 구조를 아래의 사진과 같이 출력해서 보여주는 명령어입니다. tree를 사용하려면 brew가 필요합니다.
    <img width="210" alt="image" src="https://user-images.githubusercontent.com/63505022/185574583-0520dd2a-a1eb-45f6-b919-f83183be445e.png">
- `dockutil` (brew install dockutil)
    - After installation, your dock will be changed. If you want more or fewer applications to be in your dock, please add or remove the path in `after_reset.sh`. `dockutil` will be deleted after setting.
    - 설치 이후 dock이 설정된 대로 변경됩니다. 만약 더 많은 혹은 적은 어플리케이션이 dock에 있길 원한다면 `# Change the path if you want more/fewer applications to be in your dock` 부분을 찾아서 설정을 변경하세요. 모든 설정이 설정된 후 dockutil은 자동으로 삭제됩니다.  
    
![image](https://user-images.githubusercontent.com/63505022/233522444-deeea919-7f72-49f7-a0d8-244d787bb72c.png)

# Troubleshooting
## Case 1:
I've tried to run brew, but I got this message / brew를 실행했으나 아래와 같은 메세지가 뜹니다:   
```
zsh: command not found: brew
```  
<img width="600" alt="image" src="https://user-images.githubusercontent.com/63505022/191436097-fcf9b24e-7e02-4623-9ed7-3c0aae6324af.png"> 

## Case 2:
If you've installed `oh-my-zsh`, you will see this message when you running shell script file / `oh-my-zsh`가 설치되어 있다면 아래와 같은 에러 메시지가 sh 파일을 실행할 때 뜹니다 : 
```
Error: Oh My Zsh can't be loaded from: sh. You need to run zsh instead.
```

## Solution 1 & 2:
Try this command below in your terminal / 아래의 명령어를 실행하세요:  
```
source ~/.zshrc
```
