-- Inserindo cozinheiras
INSERT INTO public.cozinheira_tb (nome, email, senha) VALUES
('Maria da Silva', 'maria@cantina.com', 'senha_hash_maria'),
('Joana Souza', 'joana@cantina.com', 'senha_hash_joana');

-- Inserindo pratos
INSERT INTO public.prato_tb (dia, turno, principal, sobremesa, bebida, imagem, id_usuario) VALUES
('2025-05-22', 'almoço', 'Arroz, feijão e frango grelhado', 'Mousse de maracujá', 'Suco de laranja', 'frango.jpg', 1),
('2025-05-23', 'almoço', 'Macarronada com carne moída', 'Pudim de leite', 'Suco de uva', 'macarrao.jpg', 2);

-- Inserindo votos
INSERT INTO public.votacao_tb (id_prato, voto, data_voto, ip_usuario) VALUES
(1, true, '2025-05-22', '192.168.0.101'),
(1, false, '2025-05-22', '192.168.0.102'),
(2, true, '2025-05-23', '192.168.0.103');

-- Atualizando um prato (alterar bebida do prato 1)
UPDATE public.prato_tb
SET bebida = 'Refrigerante de guaraná'
WHERE id_prato = 1;

-- Deletando um voto (remover o voto falso do IP 192.168.0.102 no prato 1)
DELETE FROM public.votacao_tb
WHERE ip_usuario = '192.168.0.102' AND id_prato = 1;

-- Selecionando todos os pratos com suas cozinheiras
SELECT p.id_prato, p.dia, p.turno, p.principal, p.sobremesa, p.bebida, p.imagem, c.nome AS cozinheira
FROM public.prato_tb p
JOIN public.cozinheira_tb c ON p.id_usuario = c.id_usuario
ORDER BY p.dia;