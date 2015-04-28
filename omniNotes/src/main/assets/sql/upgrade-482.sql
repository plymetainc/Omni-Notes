/*
* Adds "alarm_fired" column to the table
*/
ALTER TABLE notes RENAME TO notes_tmp;
CREATE
	TABLE notes
	(
		note_id INTEGER PRIMARY KEY AUTOINCREMENT,
		creation INTEGER,
		last_modification INTEGER,
		title TEXT,
		content TEXT,
		archived INTEGER,
		trashed INTEGER,
		alarm INTEGER DEFAULT null,
        reminder_fired INTEGER,
		recurrence_rule TEXT,
		latitude REAL,
		longitude REAL,
		address TEXT,
		category_id INTEGER DEFAULT null,
		locked INTEGER,  
		checklist  INTEGER
	);
INSERT INTO notes(note_id, creation, last_modification, title, content, archived, trashed, alarm, recurrence_rule, latitude, longitude,
 address, category_id, locked, checklist)
SELECT note_id, creation, last_modification, title, content, archived, trashed, alarm, recurrence_rule, latitude, longitude, address,
category_id, locked, checklist
FROM notes_tmp;

UPDATE notes
SET reminder_fired = 1
WHERE alarm >= (SELECT strftime('%s', 'now') + 1000);

DROP TABLE notes_tmp; 
