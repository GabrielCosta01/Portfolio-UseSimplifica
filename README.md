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

### DNS

O apex está no ar. O `www` **não** está configurado:

```
A    @      76.76.21.21    ✅
A    www    76.76.21.21    ⬅ falta no Registro.br
```

⚠️ **Não adicione o www como domínio do projeto na Vercel antes de criar
o registro A.** Foi o que derrubou o site em 01/09/2026: com os dois
domínios no projeto, a Vercel elegeu o `www` como canônico e passou a
redirecionar o apex (307) para um host que não resolve. A correção foi
limpar o campo `redirect` do apex e remover o `www` do projeto:

```
PATCH /v9/projects/{id}/domains/usesimplifica.com.br  {"redirect": null}
DELETE /v9/projects/{id}/domains/www.usesimplifica.com.br
```

A ordem correta é: criar o registro A do `www` primeiro, só então
adicionar o domínio ao projeto.

⚠️ **Não troque os nameservers.** Os subdomínios `link`, `parceria` e `imob`
apontam para outros projetos via CNAME e cairiam junto.

O domínio `simplifica-portfolio.vercel.app` redireciona com 308 para o
domínio próprio (`vercel.json`), para não competir como conteúdo duplicado.

---

## Conteúdo

Os cinco cases são projetos reais, com link ao vivo e descrições
conferidas nas próprias páginas.

A faixa de números não afirma resultado que ninguém mediu. São dois
compromissos de serviço que dependem só de cumprir (48 h de prazo,
30 dias de ajustes), a contagem de projetos linkados na própria página,
e a política de não usar tema pronto.

A frase "nenhuma página passa de 1 MB" vem de medição dos seis sites
no ar em 01/09/2026: o mais leve tem 118 KB, o mais pesado 913 KB,
mediana de 390 KB. Se entrar um projeto mais pesado que isso, a frase
precisa mudar.

O dado de 53% de abandono acima de 3 segundos é do Google/Think with
Google e está citado na página.

O exemplo da campanha usa CPC de R$ 2,40 e está rotulado como exemplo.
Ajuste se o CPC típico dos seus clientes for outro.
