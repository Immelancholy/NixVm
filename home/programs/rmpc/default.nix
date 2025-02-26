{
  imports = [
    ./themes
  ];
  xdg.configFile."rmpc/config.ron".text = ''
    #![enable(implicit_some)]
    #![enable(unwrap_newtypes)]
    #![enable(unwrap_variant_newtypes)]
    (
        address: "/run/user/1000/mpd/socket",
        password: None,
        theme: Some("catppuccin-mocha"),
        cache_dir: None,
        on_song_change: None,
        volume_step: 1,
        scrolloff: 0,
        wrap_navigation: false,
        enable_mouse: true,
        status_update_interval_ms: 1000,
        select_current_song_on_change: false,
        album_art: (
            method: Auto,
            max_size_px: (width: 600, height: 600),
            disabled_protocols: ["http://", "https://"],
        ),
        keybinds: (
            global: {
                ":":       CommandMode,
                ",":       VolumeDown,
                "s":       Stop,
                ".":       VolumeUp,
                "<Tab>":   NextTab,
                "<S-Tab>": PreviousTab,
                "1":       SwitchToTab("Queue"),
                "2":       SwitchToTab("Directories"),
                "3":       SwitchToTab("Album Artists"),
                "4":       SwitchToTab("Albums"),
                "5":       SwitchToTab("Playlists"),
                "6":       SwitchToTab("Search"),
                "q":       Quit,
                ">":       NextTrack,
                "p":       TogglePause,
                "<":       PreviousTrack,
                "f":       SeekForward,
                "z":       ToggleRepeat,
                "x":       ToggleRandom,
                "c":       ToggleConsume,
                "v":       ToggleSingle,
                "b":       SeekBack,
                "~":       ShowHelp,
                "I":       ShowCurrentSongInfo,
                "O":       ShowOutputs,
                "P":       ShowDecoders,
            },
            navigation: {
                "k":         Up,
                "j":         Down,
                "h":         Left,
                "l":         Right,
                "<Up>":      Up,
                "<Down>":    Down,
                "<Left>":    Left,
                "<Right>":   Right,
                "<C-k>":     PaneUp,
                "<C-j>":     PaneDown,
                "<C-h>":     PaneLeft,
                "<C-l>":     PaneRight,
                "<C-u>":     UpHalf,
                "N":         PreviousResult,
                "a":         Add,
                "A":         AddAll,
                "r":         Rename,
                "n":         NextResult,
                "g":         Top,
                "<Space>":   Select,
                "<C-Space>": InvertSelection,
                "G":         Bottom,
                "<CR>":      Confirm,
                "i":         FocusInput,
                "J":         MoveDown,
                "<C-d>":     DownHalf,
                "/":         EnterSearch,
                "<C-c>":     Close,
                "<Esc>":     Close,
                "K":         MoveUp,
                "D":         Delete,
            },
            queue: {
                "D":       DeleteAll,
                "<CR>":    Play,
                "<C-s>":   Save,
                "a":       AddToPlaylist,
                "d":       Delete,
                "i":       ShowInfo,
                "C":       JumpToCurrent,
            },
        ),
        search: (
            case_sensitive: false,
            mode: Contains,
            tags: [
                (value: "any",         label: "Any Tag"),
                (value: "album",       label: "Album"),
                (value: "artist",       label: "Artist"),
                (value: "albumartist", label: "Album Artist"),
                (value: "title",       label: "Title"),
                (value: "filename",    label: "Filename"),
                (value: "genre",       label: "Genre"),
            ],
        ),
        artists: (
            album_display_mode: SplitByDate,
            album_sort_by: Date,
        ),
        tabs: [
            (
                name: "Queue",
                border_type: None,
                pane: Split(
                    direction: Horizontal,
                    panes: [(size: "55%", pane: Pane(AlbumArt)), (size: "45%", pane: Pane(Queue))],
                ),
            ),
            (
                name: "Directories",
                border_type: None,
                pane: Pane(Directories),
            ),
            (
                name: "Album Artists",
                border_type: None,
                pane: Pane(AlbumArtists),
            ),
            (
                name: "Albums",
                border_type: None,
                pane: Pane(Albums),
            ),
            (
                name: "Playlists",
                border_type: None,
                pane: Pane(Playlists),
            ),
            (
                name: "Search",
                border_type: None,
                pane: Pane(Search),
            ),
        ],
    )

  '';
}
