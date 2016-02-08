const low = require('lowdb');
const storage = require('lowdb/file-sync');


module.exports = function(config) {
  const db = low(config.connectionString, {
    storage
  });
  db._.mixin(require('underscore-db'));

  return {
    wolitems: {
      save: function(wolitem) {
        db('wolitems').insert(wolitem);
        return wolitem;
      },
      all: function() {
        return db('wolitems');
      }
    }
  };
};