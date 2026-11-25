import * as migration_20261105_074825_initial from './20261105_074825_initial';
import * as migration_20261105_101518_localization from './20261105_101518_localization';

export const migrations = [
  {
    up: migration_20261105_074825_initial.up,
    down: migration_20261105_074825_initial.down,
    name: '20261105_074825_initial',
  },
  {
    up: migration_20261105_101518_localization.up,
    down: migration_20261105_101518_localization.down,
    name: '20261105_101518_localization'
  },
];
