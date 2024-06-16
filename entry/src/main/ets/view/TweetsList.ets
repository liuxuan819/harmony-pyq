import TweetsListViewModel, { TweetsItem } from '../viewModel/TweetsListViewModel'
import { Profile } from './Profile';
import { TweetsListItems } from './TweetsListItem';

@Component
export struct TweetsList {
  @State tweetsList: TweetsItem[] = [];

  aboutToAppear() {
    TweetsListViewModel.getTweets().then((tweetsList: TweetsItem[]) => this.tweetsList = tweetsList);
  }

  build() {
    List() {
      ListItem() {
        Profile()
      }


      ForEach(this.tweetsList, (tweets: TweetsItem) => {
        ListItem() {
          TweetsListItems({ tweets })
        }
      })
    }
    .height('auto')
    .width('100%')
  }
}
