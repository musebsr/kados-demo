BEGIN;

-- A data fixture for annoucements and questions which can be added through REST API as
-- the API is not yet fully implemented. Only the data models exists. 

-- Announcements
INSERT INTO announcements (category, priority, created_at, updated_at) VALUES
    ('INFORMATION', 'MEDIUM', NOW(), NOW()),
    ('INFORMATION', 'LOW', NOW(), NOW());

-- AnnouncementsTexts
INSERT INTO announcement_texts (announcement_id, text, language_id, created_at, updated_at) VALUES
    (1, 'Bienvenue dans le service de livres de la BSR.', 1, NOW(), NOW()),
    (1, 'Bienvenue dans le service de livres de la BSR.', 2, NOW(), NOW()),
    (2, 'N hésitez pas à utiliser et explorer ce service. N oubliez pas de marquer les annonces comme lues lorsque vous les avez lues.', 1, NOW(), NOW()),
    (2, 'N hésitez pas à utiliser et explorer ce service. N oubliez pas de marquer les annonces comme lues lorsque vous les avez lues.', 2, NOW(), NOW());

-- AnnouncementAudios
INSERT INTO announcement_audios (announcement_text_id, size, length, mime_type, audio, created_at, updated_at) VALUES
    (1, 24677, 2594, 'audio/ogg', 'announcement_1.ogg', NOW(), NOW()),
    (2, 27392, 2880, 'audio/ogg', 'announcement_2.ogg', NOW(), NOW()),
    (3, 53310, 5680, 'audio/ogg', 'announcement_3.ogg', NOW(), NOW()),
    (4, 63226, 6952, 'audio/ogg', 'announcement_4.ogg', NOW(), NOW());

-- UserAnnouncements
INSERT INTO user_announcements (user_id, announcement_id, created_at, updated_at) VALUES
    (1, 1, NOW(), NOW()),
    (1, 2, NOW(), NOW()),
    (2, 1, NOW(), NOW()),
    (2, 2, NOW(), NOW()),
    (3, 1, NOW(), NOW()),
    (3, 2, NOW(), NOW()),
    (4, 1, NOW(), NOW()),
    (4, 2, NOW(), NOW()),
    (5, 1, NOW(), NOW()),
    (5, 2, NOW(), NOW()),
    (6, 1, NOW(), NOW()),
    (6, 2, NOW(), NOW()),
    (7, 1, NOW(), NOW()),
    (7, 2, NOW(), NOW()),
    (8, 1, NOW(), NOW()),
    (8, 2, NOW(), NOW()),
    (9, 1, NOW(), NOW()),
    (9, 2, NOW(), NOW()),
    (10, 1, NOW(), NOW()),
    (10, 2, NOW(), NOW()),
    (11, 1, NOW(), NOW()),
    (11, 2, NOW(), NOW());

-- Questions
INSERT INTO questions (id, parent_id, question_type_id, created_at, updated_at) VALUES
    (1, 0, 1, NOW(), NOW()), -- MENU PRINCIPAL
    (2, 1, 3, NOW(), NOW()), -- option de recherche
    (3, 1, 3, NOW(), NOW()), -- option de navigation
    (4, 1, 3, NOW(), NOW()), -- option de retour
    (20, 2, 1, NOW(), NOW()), -- MENU RECHERCHE
    (21, 20, 3, NOW(), NOW()), -- recherche par auteur
    (22, 20, 3, NOW(), NOW()), -- recherche par titre
    (23, 21, 2, NOW(), NOW()), -- entrée pour recherche par auteur
    (24, 22, 2, NOW(), NOW()), -- entrée pour recherche par titre
    (25, 23, 4, NOW(), NOW()), -- point de terminaison pour recherche par auteur
    (26, 24, 4, NOW(), NOW()), -- point de terminaison pour recherche par titre
    (30, 3, 1, NOW(), NOW()), -- MENU NAVIGATION
    (31, 30, 3, NOW(), NOW()), -- navigation par titre
    -- (32, 30, 3, NOW(), NOW()), -- navigation par format Daisy2
    -- (33, 30, 3, NOW(), NOW()), -- navigation par format Daisy3
    (34, 31, 4, NOW(), NOW()), -- point de terminaison pour navigation par titre
    -- (35, 32, 4, NOW(), NOW()), -- point de terminaison pour navigation par Daisy2
    -- (36, 33, 4, NOW(), NOW()), -- point de terminaison pour navigation par Daisy3
    (40, 4, 1, NOW(), NOW()), -- MENU RETOUR (évaluer)
    (41, 4, 2, NOW(), NOW()), -- MENU RETOUR (retour personnalisé)
    (42, 40, 3, NOW(), NOW()), -- option d'évaluation excellent
    (43, 40, 3, NOW(), NOW()), -- option d'évaluation bon
    (44, 40, 3, NOW(), NOW()), -- option d'évaluation passable
    (45, 40, 3, NOW(), NOW()), -- option d'évaluation mauvais
    (46, 41, 5, NOW(), NOW()), -- point de terminaison pour retour
    (47, 42, 5, NOW(), NOW()), -- point de terminaison pour retour
    (48, 43, 5, NOW(), NOW()), -- point de terminaison pour retour
    (49, 44, 5, NOW(), NOW()), -- point de terminaison pour retour
    (50, 45, 5, NOW(), NOW()); -- point de terminaison pour retour
ALTER SEQUENCE questions_id_seq RESTART WITH 51;

-- QuestionInputs
INSERT INTO question_inputs (question_id, created_at, updated_at) VALUES
    (1, NOW(), NOW()),
    (20, NOW(), NOW()),
    (30, NOW(), NOW()),
    (40, NOW(), NOW());
INSERT INTO question_inputs (question_id, text_alphanumeric, created_at, updated_at) VALUES
    (23, 1, NOW(), NOW()),
    (24, 1, NOW(), NOW()),
    (41, 1, NOW(), NOW());

-- QuestionTexts
INSERT INTO question_texts (language_id, text, created_at, updated_at) VALUES 
    (1, 'Rechercher ou parcourir', NOW(), NOW()),
    (2, 'Que souhaitez-vous faire?', NOW(), NOW()),
    (1, 'Recherche', NOW(), NOW()),
    (2, 'Rechercher dans la bibliothèque.', NOW(), NOW()),
    (1, 'Parcourir la bibliothèque.', NOW(), NOW()),
    (2, 'Parcourir', NOW(), NOW()),
    -- (1, 'Donner votre avis.', NOW(), NOW()),
    --  (2, 'Donner votre avis.', NOW(), NOW()),
    (1, 'Que voulez-vous rechercher?', NOW(), NOW()),
    (2, 'Que voulez-vous rechercher?', NOW(), NOW()),
    (1, 'Recherche par auteur', NOW(), NOW()),
    (2, 'Rechercher par auteur.', NOW(), NOW()),
    (1, 'Rechercher par titre', NOW(), NOW()),
    (2, 'Rechercher par titre.', NOW(), NOW()),
    (1, 'Mots-clés auteur :', NOW(), NOW()),
    (2, 'Mots-clés auteur :', NOW(), NOW()),
    (1, 'Mots-clés titre :', NOW(), NOW()),
    (2, 'Mots-clés titre :', NOW(), NOW()),
    (1, 'Comment souhaitez-vous parcourir la bibliothèque?', NOW(), NOW()),
    (2, 'Comment souhaitez-vous parcourir la bibliothèque?', NOW(), NOW()),
    (1, 'Parcourir par titre.', NOW(), NOW()),
    (2, 'Parcourir par titre.', NOW(), NOW()),
    (1, 'Parcourir par format Daisy 2.', NOW(), NOW()),
    (2, 'Parcourir par format Daisy 2.', NOW(), NOW()),
    (1, 'Parcourir par format Daisy 3.', NOW(), NOW()),
    (2, 'Parcourir par format Daisy 3.', NOW(), NOW()),
    (1, 'Comment évalueriez-vous ce service?', NOW(), NOW()),
    (2, 'Comment évalueriez-vous ce service?', NOW(), NOW()),
    (1, 'Retour facultatif ?', NOW(), NOW()),
    (2, 'Retour facultatif ?', NOW(), NOW()),
    (1, 'Excellent.', NOW(), NOW()),
    (2, 'Excellent.', NOW(), NOW()),
    (1, 'Bon.', NOW(), NOW()),
    (2, 'Bon.', NOW(), NOW()),
    (1, 'Passable.', NOW(), NOW()),
    (2, 'Passable.', NOW(), NOW()),
    (1, 'Mauvais.', NOW(), NOW()),
    (2, 'Mauvais.', NOW(), NOW()),
    (1, 'Merci pour votre retour.', NOW(), NOW()),
    (2, 'Merci pour votre retour.', NOW(), NOW());

-- QuestionAudios
INSERT INTO question_audios (question_text_id, size, length, mime_type, audio, created_at, updated_at) VALUES
    (1, 13817, 1303, 'audio/ogg', 'question_1.ogg', NOW(), NOW()),
    (2, 14634, 1049, 'audio/ogg', 'question_2.ogg', NOW(), NOW()),
    (3, 13649, 1016, 'audio/ogg', 'question_3.ogg', NOW(), NOW()),
    (4, 14255, 1358, 'audio/ogg', 'question_4.ogg', NOW(), NOW()),
    (5, 13414, 971, 'audio/ogg', 'question_5.ogg', NOW(), NOW()),
    (6, 14323, 1427, 'audio/ogg', 'question_6.ogg', NOW(), NOW()),
    (7, 10317, 776, 'audio/ogg', 'question_7.ogg', NOW(), NOW()),
    (8, 11936, 865, 'audio/ogg', 'question_8.ogg', NOW(), NOW()),
    (9, 16948, 1731, 'audio/ogg', 'question_9.ogg', NOW(), NOW()),
    (10, 15906, 1495, 'audio/ogg', 'question_10.ogg', NOW(), NOW()),
    (11, 12455, 920, 'audio/ogg', 'question_11.ogg', NOW(), NOW()),
    (12, 12857, 1475, 'audio/ogg', 'question_12.ogg', NOW(), NOW()),
    (13, 10729, 1016, 'audio/ogg', 'question_13.ogg', NOW(), NOW()),
    (14, 11504, 1092, 'audio/ogg', 'question_14.ogg', NOW(), NOW()),
    (15, 11760, 926, 'audio/ogg', 'question_15.ogg', NOW(), NOW()),
    (16, 13190, 1380, 'audio/ogg', 'question_16.ogg', NOW(), NOW()),
    (17, 9871, 972, 'audio/ogg', 'question_17.ogg', NOW(), NOW()),
    (18, 9975, 997, 'audio/ogg', 'question_18.ogg', NOW(), NOW()),
    (19, 22087, 1985, 'audio/ogg', 'question_19.ogg', NOW(), NOW()),
    (20, 21288, 2002, 'audio/ogg', 'question_20.ogg', NOW(), NOW()),
    (21, 9715, 972, 'audio/ogg', 'question_21.ogg', NOW(), NOW()),
    (22, 13854, 1339, 'audio/ogg', 'question_22.ogg', NOW(), NOW()),
    (23, 19397, 2018, 'audio/ogg', 'question_23.ogg', NOW(), NOW()),
    (24, 20361, 2267, 'audio/ogg', 'question_24.ogg', NOW(), NOW()),
    (25, 19313, 2052, 'audio/ogg', 'question_25.ogg', NOW(), NOW()),
    (26, 21900, 2292, 'audio/ogg', 'question_26.ogg', NOW(), NOW()),
    (27, 17356, 1507, 'audio/ogg', 'question_27.ogg', NOW(), NOW()),
    (28, 21999, 2198, 'audio/ogg', 'question_28.ogg', NOW(), NOW()),
    (29, 11525, 1027, 'audio/ogg', 'question_29.ogg', NOW(), NOW()),
    (30, 15271, 1219, 'audio/ogg', 'question_30.ogg', NOW(), NOW()),
    (31, 8239, 635, 'audio/ogg', 'question_31.ogg', NOW(), NOW()),
    (32, 9086, 662, 'audio/ogg', 'question_32.ogg', NOW(), NOW()),
    (33, 5465, 324, 'audio/ogg', 'question_33.ogg', NOW(), NOW()),
    (34, 8102, 447, 'audio/ogg', 'question_34.ogg', NOW(), NOW()),
    (35, 7485, 394, 'audio/ogg', 'question_35.ogg', NOW(), NOW()),
    (36, 6234, 424, 'audio/ogg', 'question_36.ogg', NOW(), NOW()),
    (37, 5358, 318, 'audio/ogg', 'question_37.ogg', NOW(), NOW()),
    (38, 7797, 429, 'audio/ogg', 'question_38.ogg', NOW(), NOW()),
    (39, 15523, 1368, 'audio/ogg', 'question_39.ogg', NOW(), NOW()),
    (40, 14041, 1320, 'audio/ogg', 'question_40.ogg', NOW(), NOW());

-- QuestionQuestionTexts
INSERT INTO question_question_texts (question_id, question_text_id, created_at, updated_at) VALUES
    (1, 1, NOW(), NOW()), --Rechercher dans la bibliothèque Unitas
    (1, 2, NOW(), NOW()), --Rechercher dans la bibliothèque Unitas
    (2, 3, NOW(), NOW()), --rechercher par...
    (2, 4, NOW(), NOW()), --rechercher par...
    (3, 5, NOW(), NOW()), --Parcourir la bibliothèque
    (3, 6, NOW(), NOW()), --Parcourir la bibliothèque
    -- (4, 7, NOW(), NOW()), -- SUPPR?
    -- (4, 8, NOW(), NOW()), -- SUPPR?
    (20, 9, NOW(), NOW()), --Que voulez-vous rechercher ?
    (20, 10, NOW(), NOW()), --Que voulez-vous rechercher ?
    (21, 11, NOW(), NOW()), --rechercher par auteur
    (21, 12, NOW(), NOW()), --rechercher par auteur
    (22, 13, NOW(), NOW()), --rechercher par titre
    (22, 14, NOW(), NOW()), --rechercher par titre
    (23, 15, NOW(), NOW()), --auteur
    (23, 16, NOW(), NOW()), --auteur
    (24, 17, NOW(), NOW()), --titre
    (24, 18, NOW(), NOW()), --titre
    (30, 19, NOW(), NOW()), --Comment voulez-vous parcourir la bibliothèque ?
    (30, 20, NOW(), NOW()), --Comment voulez-vous parcourir la bibliothèque ?
    (31, 21, NOW(), NOW()), --parcourir par titre
    (31, 22, NOW(), NOW()); --parcourir par titre
    -- (32, 41, NOW(), NOW()), --parcourir par âge
    -- (32, 42, NOW(), NOW()), --parcourir par âge
    -- (40, 41, NOW(), NOW()), --Âge
    -- (40, 42, NOW(), NOW()), --Âge
    -- (41, 43, NOW(), NOW()), --6 8 ans
    -- (41, 44, NOW(), NOW()), --6 8 ans
    -- (42, 45, NOW(), NOW()), --9 11 ans
    -- (42, 46, NOW(), NOW()), --9 11 ans
    -- (43, 47, NOW(), NOW()), --12 14 ans
    -- (43, 48, NOW(), NOW()), --12 14 ans
    -- (44, 49, NOW(), NOW()), --15 18 ans
    -- (44, 50, NOW(), NOW()), --15 18 ans
    -- (45, 51, NOW(), NOW()), --


COMMIT;