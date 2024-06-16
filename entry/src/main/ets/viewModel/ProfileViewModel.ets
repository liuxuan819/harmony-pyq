import { httpRequestGet } from '../common/utils/HttpUtil';
import prompt from '@ohos.promptAction';

class ProfileViewModel {
  getProfile(): Promise<ProfileModel> {
    const url = 'https://xianmobilelab.gitlab.io/moments-data/user.json';
    return new Promise(async (resolve: Function) => {
      httpRequestGet(url)
        .then((profile: ProfileModel) => resolve(profile))
        .catch(() => prompt.showToast({ message: '获取个人信息失败' }));
    })
  }
}

export class ProfileModel {
  'profile-image': string = '';
  avatar: string = '';
  nick: string = '';
  username: string = '';
}

let profileViewModel = new ProfileViewModel();
export default profileViewModel as ProfileViewModel;
