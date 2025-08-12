// This file was auto-generated. DO NOT modify this file by hand.
// Generated on 2025-08-11


export const APP_NAME: string = "Training Portal";
export const BUILD_ID: number = 20250811;
export let max_rows_per_page: number = 10;

export interface TrainingSession {
	title: string;
	facilitator: string;
	date: string;
	location: string;
	duration_hours: number;
	capacity: number;
};
     
export const training_sessions: Array<TrainingSession> = [
	{ title: "Effective Communication", facilitator: "Jane Smith", date: "2025-09-15", location: "Room 201", duration_hours: 2., capacity: 30. },
	{ title: "Time Management Basics", facilitator: "Robert Lee", date: "2025-09-20", location: "Room 105", duration_hours: 1., capacity: 25. },
	{ title: "Conflict Resolution", facilitator: "Maria Gomez", date: "2025-09-22", location: "Room 207", duration_hours: 2., capacity: 20. },
	{ title: "Workplace Safety 101", facilitator: "David Chen", date: "2025-09-25", location: "Main Auditorium", duration_hours: 3., capacity: 100. },
	{ title: "Intro to Project Management", facilitator: "Emily Davis", date: "2025-09-28", location: "Room 301", duration_hours: 2., capacity: 35. },
	{ title: "Inclusive Leadership", facilitator: "Michael Thompson", date: "2025-10-01", location: "Room 102", duration_hours: 2., capacity: 25. },
	{ title: "Cybersecurity Awareness", facilitator: "Sarah Patel", date: "2025-10-05", location: "Room 208", duration_hours: 1., capacity: 50. },
	{ title: "Health and Wellness Seminar", facilitator: "Linda Roberts", date: "2025-10-07", location: "Room 106", duration_hours: 1., capacity: 40. }
];
