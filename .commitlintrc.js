const storyIdRegex = /\d{1,9}:/;
const messageRegex = /[A-Z].{9,}/;
const commitRegex = new RegExp('^' + storyIdRegex.source + ' ' + messageRegex.source + '$');

module.exports = {
  parserPreset: {
    parserOpts: {
      headerPattern: /.*/,
    },
  },
  rules: {
    'header-max-length': [2, 'always', 215],
    'story-id-pattern': [2, 'always'],
    'message-pattern': [2, 'always'],
    'header-pattern': [2, 'always'],
  },
  plugins: [
    {
      rules: {
        'header-pattern': (parsed) => {
          const {header} = parsed;
          if (!header.match(commitRegex)) {
            return [false, `commit header doesn't match correct format. (example: 123456789: Commit description)`];
          }
          return [true, 'valid'];
        },
        'story-id-pattern': (parsed) => {
          const {header} = parsed;
          if (!header.match(storyIdRegex)) {
            return [false, `could not find valid story id. (example: 123456789:)`];
          }
          return [true, 'valid'];
        },
        'message-pattern': (parsed) => {
          const {header} = parsed;
          if (!header.match(messageRegex)) {
            return [
              false,
              `could not find valid commit message starting with a capital letter with 10+ characters. (example: A descriptive commit message)`,
            ];
          }
          return [true, 'valid'];
        },
      },
    },
  ],
};
