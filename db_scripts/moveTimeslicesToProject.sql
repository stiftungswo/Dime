/*
 * This script can be used to move timeslices
 * in a certain time range from one project to another
 *
 * Replace project IDs and Date range
 */
UPDATE timeslices t
INNER JOIN activities a_origin ON t.activity_id = a_origin.id AND a_origin.project_id = 323
SET t.activity_id =
(
	SELECT a_dest.id
	FROM activities a_dest
  WHERE a_dest.service_id = a_origin.service_id
  AND a_dest.project_id = 383
)
WHERE t.stopped_at < '2017-08-01';
