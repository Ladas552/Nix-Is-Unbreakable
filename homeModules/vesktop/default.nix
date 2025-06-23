{ lib, config, ... }:

{
  options.customhm = {
    vesktop.enable = lib.mkEnableOption "enable vesktop";
  };
  config = lib.mkIf config.customhm.vesktop.enable {
    services.arrpc.enable = true;
    programs.vesktop = {
      enable = true;
      settings = {
        discordBranch = "stable";
        minimizeToTray = true;
        arRPC = config.services.arrpc.enable;
        splashColor = "rgb(218, 219, 222)";
        splashBackground = "rgb(11, 12, 13)";
        spellCheckLanguages = [
          "en-US"
          "en"
        ];
      };
      vencord = {
        settings = {
          notifyAboutUpdates = false;
          autoUpdate = true;
          autoUpdateNotification = false;
          useQuickCss = true;
          enableReactDevtools = false;
          frameless = false;
          transparent = false;
          winCtrlQ = false;
          disableMinSize = false;
          winNativeTitleBar = false;
          notifications = {
            timeout = 5000;
            position = "top-right";
            useNative = "not-focused";
            logLimit = 5;
          };
          cloud = {
            authenticated = false;
            url = "https://api.vencord.dev/";
            settingsSync = false;
            settingsSyncVersion = 174533173837;
          };
          eagerPatches = false;
          themeLinks = [
            "https://dablulite.github.io/css-snippets/PrettyFolderIcons/import.css"
            "https://aushevahmad.github.io/awesome-css/modules/channeltweaks.css"
            "https://aushevahmad.github.io/awesome-css/modules/declutter.css"
            "https://minidiscordthemes.github.io/Snippets/ForumImprovements/main.css"
            "https://raw.githubusercontent.com/tom22k/discord-css/main/Themes/HideNitroUpsellV2.css"
            "https://aushevahmad.github.io/awesome-css/modules/compressbotmsgs.css"
            "https://dablulite.github.io/css-snippets/TabsV2HomeIcon/import.css"
          ];
          plugins = {
            BadgeAPI = {
              enabled = true;
            };
            ChatInputButtonAPI = {
              enabled = true;
            };
            CommandsAPI = {
              enabled = true;
            };
            ContextMenuAPI = {
              enabled = true;
            };
            MemberListDecoratorsAPI = {
              enabled = true;
            };
            MessageAccessoriesAPI = {
              enabled = true;
            };
            MessageDecorationsAPI = {
              enabled = true;
            };
            MessageEventsAPI = {
              enabled = true;
            };
            MessagePopoverAPI = {
              enabled = true;
            };
            NoticesAPI = {
              enabled = true;
            };
            ServerListAPI = {
              enabled = true;
            };
            NoTrack = {
              enabled = true;
              disableAnalytics = true;
            };
            Settings = {
              enabled = true;
              settingsLocation = "aboveActivity";
            };
            SupportHelper = {
              enabled = true;
            };
            AlwaysTrust = {
              enabled = true;
              domain = true;
              file = true;
            };
            BetterGifAltText = {
              enabled = true;
            };
            BetterGifPicker = {
              enabled = true;
            };
            BetterNotesBox = {
              enabled = true;
              hide = true;
              noSpellCheck = false;
            };
            BetterRoleContext = {
              enabled = true;
              roleIconFileFormat = "png";
            };
            BetterSettings = {
              enabled = true;
              disableFade = true;
              eagerLoad = true;
            };
            BetterUploadButton = {
              enabled = true;
            };
            BlurNSFW = {
              enabled = true;
              blurAmount = 10;
            };
            ClearURLs = {
              enabled = true;
            };
            ClientTheme = {
              enabled = true;
              color = "313338";
            };
            ColorSighted = {
              enabled = true;
            };
            CopyUserURLs = {
              enabled = true;
            };
            CrashHandler = {
              enabled = true;
            };
            Dearrow = {
              enabled = true;
              hideButton = false;
              replaceElements = 0;
              dearrowByDefault = true;
            };
            DisableCallIdle = {
              enabled = true;
            };
            FakeNitro = {
              enabled = true;
              enableEmojiBypass = true;
              emojiSize = 48;
              transformEmojis = true;
              enableStickerBypass = true;
              stickerSize = 160;
              transformStickers = true;
              transformCompoundSentence = false;
              enableStreamQualityBypass = false;
              useHyperLinks = true;
              hyperLinkText = "𝃚";
              disableEmbedPermissionCheck = false;
            };
            FavoriteEmojiFirst = {
              enabled = true;
            };
            FavoriteGifSearch = {
              enabled = true;
            };
            FixCodeblockGap = {
              enabled = true;
            };
            FixSpotifyEmbeds = {
              enabled = true;
            };
            FixYoutubeEmbeds = {
              enabled = true;
            };
            ForceOwnerCrown = {
              enabled = true;
            };
            FriendsSince = {
              enabled = true;
            };
            GreetStickerPicker = {
              enabled = true;
            };
            LoadingQuotes = {
              enabled = true;
              replaceEvents = true;
              enableDiscordPresetQuotes = false;
              additionalQuotes = "";
              additionalQuotesDelimiter = "|";
              enablePluginPresetQuotes = true;
            };
            MemberCount = {
              enabled = true;
              memberList = true;
              toolTip = true;
            };
            MessageLinkEmbeds = {
              enabled = true;
              listMode = "blacklist";
              idList = ",";
              automodEmbeds = "never";
            };
            MessageTags = {
              enabled = true;
            };
            MoreKaomoji = {
              enabled = true;
            };
            NoF1 = {
              enabled = true;
            };
            NoPendingCount = {
              enabled = true;
              hideFriendRequestsCount = false;
              hideMessageRequestsCount = false;
              hidePremiumOffersCount = true;
            };
            NoTypingAnimation = {
              enabled = true;
            };
            NoUnblockToJump = {
              enabled = true;
            };
            NSFWGateBypass = {
              enabled = true;
            };
            OnePingPerDM = {
              enabled = true;
              channelToAffect = "both_dms";
              allowMentions = false;
              allowEveryone = false;
            };
            OpenInApp = {
              enabled = true;
              spotify = true;
              steam = true;
              epic = true;
              tidal = true;
              itunes = true;
            };
            petpet = {
              enabled = true;
            };
            PlatformIndicators = {
              enabled = true;
              colorMobileIndicator = true;
              list = true;
              badges = true;
              messages = true;
            };
            PreviewMessage = {
              enabled = true;
            };
            QuickReply = {
              enabled = true;
            };
            ReadAllNotificationsButton = {
              enabled = true;
            };
            RelationshipNotifier = {
              enabled = true;
              offlineRemovals = true;
              groups = true;
              servers = true;
              friends = true;
              friendRequestCancels = true;
              notices = false;
            };
            ReverseImageSearch = {
              enabled = true;
            };
            ShowHiddenChannels = {
              enabled = true;
              showMode = 0;
              hideUnreads = true;
              defaultAllowedUsersAndRolesDropdownState = true;
            };
            ShowMeYourName = {
              enabled = true;
              mode = "nick-user";
              displayNames = false;
              inReplies = true;
            };
            SilentMessageToggle = {
              enabled = true;
              persistState = false;
              autoDisable = true;
            };
            Translate = {
              enabled = true;
              autoTranslate = false;
              receivedInput = "auto";
              receivedOutput = "en";
              showChatBarButton = true;
              sentInput = "auto";
              sentOutput = "en";
            };
            TypingTweaks = {
              enabled = true;
              alternativeFormatting = true;
              showRoleColors = true;
              showAvatars = true;
            };
            Unindent = {
              enabled = true;
            };
            UrbanDictionary = {
              enabled = true;
            };
            UserVoiceShow = {
              enabled = true;
              showVoiceChannelSectionHeader = true;
              showInUserProfileModal = true;
              showInMemberList = true;
              showInMessages = true;
            };
            ValidUser = {
              enabled = true;
            };
            VoiceChatDoubleClick = {
              enabled = true;
            };
            ViewIcons = {
              enabled = true;
              format = "webp";
              imgSize = 1024;
            };
            ViewRaw = {
              enabled = true;
              clickMethod = "Left";
            };
            VoiceMessages = {
              enabled = true;
            };
            WebContextMenus = {
              enabled = true;
              addBack = true;
            };
            WebKeybinds = {
              enabled = true;
            };
            WhoReacted = {
              enabled = true;
            };
            Wikisearch = {
              enabled = true;
            };
            UnlockedAvatarZoom = {
              enabled = true;
            };
            ShowHiddenThings = {
              enabled = true;
              showTimeouts = true;
              showInvitesPaused = true;
              showModView = true;
              disableDiscoveryFilters = true;
              disableDisallowedDiscoveryFilters = true;
            };
            ValidReply = {
              enabled = true;
            };
            WebScreenShareFixes = {
              enabled = true;
            };
            MessageUpdaterAPI = {
              enabled = true;
            };
            ServerInfo = {
              enabled = true;
            };
            SettingsStoreAPI = {
              enabled = true;
            };
            NoOnboardingDelay = {
              enabled = true;
            };
            UserSettingsAPI = {
              enabled = true;
            };
            YoutubeAdblock = {
              enabled = true;
            };
            MentionAvatars = {
              enabled = true;
              showAtSymbol = true;
            };
            FullSearchContext = {
              enabled = true;
            };
            CopyFileContents = {
              enabled = true;
            };
            UserMessagesPronouns = {
              enabled = true;
              showInMessages = true;
              showSelf = true;
              pronounSource = 0;
              pronounsFormat = "LOWERCASE";
              showInProfile = true;
            };
            DynamicImageModalAPI = {
              enabled = true;
            };
            HideMedia = {
              enabled = true;
            };
            DisableDeepLinks = {
              enabled = true;
            };
            "WebRichPresence (arRPC)" = {
              enabled = config.services.arrpc.enable;
            };
          };
        };
        themes.enabledThemes = '''';
      };
    };
  };
}
