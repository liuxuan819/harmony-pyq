import { httpRequestGet } from '../common/utils/HttpUtil';
import { ProfileModel } from './ProfileViewModel';
import prompt from '@ohos.promptAction';

class TweetsListViewModel {
  private  tweetsList: TweetsItem[] = [];

  getTweets(page: number = 1, pageSize: number = 5): Promise<TweetsItem[]> {
    return new Promise(async (resolve: Function) => {
      if (this.tweetsList.length) {
        resolve(this.sliceTweets(page, pageSize));
      } else {
        const url = 'https://xianmobilelab.gitlab.io/moments-data/tweets.json';
        httpRequestGet(url)
          .then((tweetsList: TweetsItem[]) => this.tweetsList = tweetsList.filter(tweets => tweets.content || tweets.images?.length))
          .catch(() => prompt.showToast({ message: '获取朋友圈推文失败' }))
          .finally(() => resolve(this.sliceTweets(page, pageSize)))
      }
    });
  }

  private sliceTweets(page: number = 1, pageSize: number = 5): TweetsItem[] {
    return this.tweetsList.slice(0, Math.min(this.tweetsList.length, page * pageSize));
  }
}

@Observed
export class TweetsItem {
  sender: ProfileModel;
  content: string;
  images: {
    url: string;
  }[];
  comments: {
    sender: ProfileModel;
    content: string;
  }[];
}

let tweetsListViewModel = new TweetsListViewModel();
export default tweetsListViewModel as TweetsListViewModel;
