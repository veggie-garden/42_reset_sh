# Reset.sh

Shell script files that download programs and change settings after resetting your 42 Mac.
초기화 이후에 필요한 프로그램을 다운받고 설정을 변경해 주는 쉘스크립트 파일입니다.

> ****Pull requests, and error reports are all welcomed.****

## Install

After reset your mac by `touch ~/.reset` and run code below.  
`touch ~/.reset`으로 맥 초기화를 진행한 후에, 아래의 코드를 실행시키세요.

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/veggie-garden/42_reset_sh/main/42_reset.sh)"
```

```diff
- ⚠️ PLEASE BACKUP ALL YOUR FILES BEFORE YOU USE `touch ~/.reset` COMMAND ⚠️
```
```diff
- ⚠️ `touch ~/.reset` 명령어는 맥을 초기화해주는 명령어입니다. 사용하시기 전에 모든 파일을 백업해두고 사용하세요! ⚠️
```

## Features

### after_reset.sh

- Install [oh_my_zsh](https://ohmyz.sh/)
  - Install oh_my_zsh. oh_my_zsh will be applied in your terminal after you finish setting 42_reset_sh.
  - oh_my_zsh를 설치해줍니다. 42_reset_sh가 종료되면 oh_my_zsh가 터미널에 적용될 것입니다.
- [42header plugin](https://github.com/42Paris/42header)
  - Able to set or reset your intra id. 인트라 ID 재설정 가능.
- GitHub config setting
  - Set [GitHub username](https://docs.github.com/en/get-started/getting-started-with-git/setting-your-username-in-git) and [GitHub user email](https://docs.github.com/en/account-and-profile/setting-up-and-managing-your-personal-account-on-github/managing-email-preferences/setting-your-commit-email-address)
  - [GitHub username](https://docs.github.com/ko/get-started/getting-started-with-git/setting-your-username-in-git)과 [GitHub user email](https://docs.github.com/ko/account-and-profile/setting-up-and-managing-your-personal-account-on-github/managing-email-preferences/setting-your-commit-email-address)을 설정해줍니다.
- Install [42toolbox](https://github.com/alexandregv/42toolbox)
- Generate ssh key
  - This command checks the existence of the SSH key (create it when it does not exist) and copies the public key into your clipboard. Your GitHub and 42 intra SSH key setting page will be opened automatically after that.
  - SSH key가 있는지 없는지 확인한 후에 public key를 클립보드에 복사합니다. SSH key를 등록하는 GitHub 페이지와 42 인트라 페이지가 자동으로 뜹니다.
- Run vscode in terminal
  - By just typing `code .` in terminal, you can open your pwd folder in vscode.
  - `code .` 이라는 명령어를 치면 pwd 폴더를 vscode로 열 수 있습니다.
- Install [42brew](https://github.com/Homebrew/brew)
- `tree` (brew install tree)
  - `tree` is a recursive directory listing command that produces a depth-indented listing of files. If you want to use it, you need to install brew.
  - `tree`는 파일 구조를 아래의 사진과 같이 출력해서 보여주는 명령어입니다. tree를 사용하려면 brew가 필요합니다.
    <img width="210" alt="image" src="https://user-images.githubusercontent.com/63505022/185574583-0520dd2a-a1eb-45f6-b919-f83183be445e.png">
- Clean dock
  - Clean dock by setting. (change utils/dock.sh line 6 if you want to change default dock setting)
  - dock을 정리해주는 기능입니다. (기본 설정을 바꾸고 싶다면 utils/dock.sh 6번째 줄을 수정하세요)

## Troubleshooting

### Case 1

I've tried to run brew, but I got this message / brew를 실행했으나 아래와 같은 메세지가 뜹니다:

```bash
zsh: command not found: brew
```

<img width="600" alt="image" src="https://user-images.githubusercontent.com/63505022/191436097-fcf9b24e-7e02-4623-9ed7-3c0aae6324af.png">

### Case 2

If you see this message when you running shell script file / 아래와 같은 에러 메시지가 실행 중에 뜹니다:  

```bash
Error: Oh My Zsh can't be loaded from: sh. You need to run zsh instead.
```

### Solution 1 & 2

Try this command below in your terminal / 아래의 명령어를 실행하세요:  

```bash
source ~/.zshrc
```
