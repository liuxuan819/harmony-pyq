import TweetsListViewModel, { TweetsItem } from '../viewModel/TweetsListViewModel'
import { Profile } from './Profile';
import { TweetsListItems } from './TweetsListItem';

@Component
export struct TweetsList {
  @State tweetsList: TweetsItem[] = [];
  @State currentPage: number = 1;
  upToStart: boolean = true;
  downToEnd: boolean = false;

  refresh(): void {
    TweetsListViewModel.getTweets().then((tweetsList: TweetsItem[]) => {
      this.tweetsList = tweetsList;
      this.currentPage = 1;
    });
  }

  loadMore(): void {
    TweetsListViewModel.getTweets(this.currentPage + 1).then((tweetsList: TweetsItem[]) => {
      this.tweetsList = tweetsList;
      this.currentPage++;
    });
  }

  onReachStart() {
    this.upToStart = !this.upToStart;
    if (!this.upToStart) {
      this.refresh();
    }
  }

  onReachEnd() {
    this.downToEnd = !this.downToEnd;
    if (!this.downToEnd) {
      this.loadMore();
    }
  }

  aboutToAppear() {
    this.refresh();
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
    .onReachStart(() => this.onReachStart())
    .onReachEnd(() => this.onReachEnd())
  }
}
