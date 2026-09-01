# Portfólio Simplifica

Site do estúdio **Simplifica** — Gabriel C Costa. Página única, estática, sem
framework e sem etapa de build: o que está no repositório é exatamente o que
vai para o ar.

**No ar:** https://simplifica-portfolio.vercel.app
**Domínio pretendido:** https://usesimplifica.com.br *(pendente de DNS, ver abaixo)*

---

## Estrutura

```
index.html            página completa — HTML, CSS e JS num arquivo só (~52 KB)
img/                  retrato recortado + previews dos cinco projetos (WebP)
og.jpg                imagem de compartilhamento, 1200×630
favicon.ico           ícones a partir do símbolo da marca
icon-*.png
apple-touch-icon.png
site.webmanifest
robots.txt
sitemap.xml
vercel.json           cache de um ano em /img e cabeçalhos de segurança

portfolio.html        mesma página com as imagens embutidas em base64.
                      É a versão usada no preview/artefato durante o design;
                      o index.html nasce dela com as imagens extraídas.

fontes/
  perfil.jfif         foto original da sessão
  perfil_nobg.png     foto com o fundo recortado (origem de img/retrato.webp)
```

### Por que dois HTML

`portfolio.html` carrega as imagens como data URI, o que é prático para
visualizar o arquivo isolado, mas ruim num site: são ~240 KB que o navegador
rebaixa a cada visita, sem cache. No `index.html` as imagens são arquivos
separados — a página cai para 52 KB e as imagens ficam em cache por um ano.

Ao mexer no design, altere `portfolio.html` e depois replique no `index.html`,
ou vice-versa. **Não deixe os dois divergirem.**

---

## Decisões que valem saber

**Tema único.** A página não tem modo claro. É um mundo visual fechado
(campo azul elétrico sobre preto azulado) e todas as cores são pintadas
explicitamente, sem herdar nada do navegador.

**Mobile-first.** As regras base do CSS descrevem o celular; as consultas
`min-width` em 560, 760 e 1080 acrescentam colunas conforme sobra largura.

**O nome atravessa o retrato.** `GABRIEL` fica atrás da cabeça e `C COSTA`
por cima do peito. Isso só funciona porque `img/retrato.webp` tem canal alpha
— se a foto for trocada, o recorte precisa vir junto.

**Nada rola sozinho.** A hero anima uma vez na entrada e para. Primeiro
aparecem foto e nome; o menu e o rodapé chegam 1,5 s depois.

**Movimento reduzido** é respeitado: com `prefers-reduced-motion`, tudo
aparece no estado final sem animação.

---

## Publicar

O projeto está ligado à Vercel (`simplifica-portfolio`). Da raiz:

```bash
vercel deploy --prod
```

### DNS pendente

O domínio `usesimplifica.com.br` já está vinculado ao projeto na Vercel, mas
os nameservers estão no **Registro.br**. Falta criar lá:

```
A    @      76.76.21.21
A    www    76.76.21.21
```

⚠️ **Não troque os nameservers.** Os subdomínios `link`, `parceria` e `imob`
apontam para outros projetos via CNAME e cairiam junto. Adicionar só o
registro A do apex não afeta nenhum deles.

---

## Pendências de conteúdo

Os cinco cases são projetos reais, com link ao vivo e descrições conferidas
nas próprias páginas. **Os números da faixa de estatísticas não são**, e
precisam virar reais ou sair antes de o domínio apontar para cá:

| Onde | O que está escrito | Situação |
|---|---|---|
| Faixa de números | 48 h do briefing ao ar | a confirmar |
| Faixa de números | 0,6 s para a página abrir | a confirmar |
| Faixa de números | +37% de conversão média | a confirmar |
| Faixa de números | 30 dias de ajustes inclusos | a confirmar |
| Topo | "2 vagas em setembro" | atualizar por mês |
| Painel do manifesto | R$ 2,40 por clique | exemplo — ajustar ao CPC real |

O dado de 53% de abandono acima de 3 segundos é do Google/Think with Google
e está citado na página.
