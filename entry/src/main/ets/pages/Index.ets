import { TweetsList } from '../view/TweetsList'

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'

  build() {
    Column() {
      TweetsList()
    }
    .width('100%')
    .height('100%')
  }
}
