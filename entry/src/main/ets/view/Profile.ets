import ProfileViewModel, { ProfileModel } from '../viewModel/ProfileViewModel';

@Component
export struct Profile {
  @State profileModel: ProfileModel = new ProfileModel();

  aboutToAppear() {
    ProfileViewModel.getProfile().then((profile: ProfileModel) => this.profileModel = profile);
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Image(this.profileModel['profile-image'])
        .alt( $r("app.media.defaultImage"))
        .width('100%')
        .height('35%')
        .margin({ bottom: 50 })
      Row() {
        Text(this.profileModel.nick)
          .fontColor(Color.White)
          .fontSize(30)
          .fontWeight(FontWeight.Bolder)
          .margin(8)
        Image(this.profileModel.avatar)
          .alt($r("app.media.defaultAvatar"))
          .width(80)
          .height(80)
          .borderRadius(12)
      }
      .alignItems(VerticalAlign.Top)
      .padding(20)
    }
    .width('100%')
  }
}
