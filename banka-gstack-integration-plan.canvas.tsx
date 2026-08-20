import {
  Button,
  Callout,
  Card,
  CardBody,
  CardHeader,
  Divider,
  Grid,
  H1,
  H2,
  H3,
  Pill,
  Row,
  Stack,
  Stat,
  Table,
  Text,
  useCanvasAction,
  useHostTheme,
} from "cursor/canvas";

const phases = [
  [
    "1",
    "Define the contract",
    "Add a Banka-native definition of operational perspectives and explicit non-goals.",
    "protocol/Banka.md",
  ],
  [
    "2",
    "Embed the useful checks",
    "Strengthen charter and survey without creating new commands or gates.",
    "skills-kit/charter, survey",
  ],
  [
    "3",
    "Normalize multi-perspective review",
    "Rename Watershed's internal persona language and align its five lenses to the shared model.",
    "skills-kit/watershed",
  ],
  [
    "4",
    "Protect the ecosystem",
    "Expand integrity checks and verify Banka, ASMP, and Docking remain independently authoritative.",
    "scripts + three repo checks",
  ],
  [
    "5",
    "Pilot before expanding",
    "Run one Oykon planning/review scenario; only then consider optional modes.",
    "scenario evidence",
  ],
];

const skillRows = [
  [
    "charter",
    "Outcome Owner by default; Builder, Maintainer, User, and Risk Owner when applicable",
    "Premise, outcome, architecture survivability, operability, and concrete failure checks become part of decision-making.",
  ],
  [
    "survey",
    "User + Maintainer + Risk Owner",
    "Retain the three existing review layers; add real-flow evidence, change-safety, and adversarial failure scenarios. Remains report-only.",
  ],
  [
    "watershed",
    "All five perspectives",
    "Reserve isolated multi-perspective analysis for contested or high-stakes decisions. Replace persona terminology, not behavior.",
  ],
  [
    "dredge",
    "Builder + Risk Owner",
    "Preserve the existing diagnose-before-fix contract. Adopt only evidence discipline where it sharpens root-cause claims.",
  ],
  [
    "moor / remember",
    "Maintainer",
    "Persist accepted decisions and outcomes only; do not add a second gstack-style memory stream.",
  ],
];

function FlowNode({ title, detail, accent = false }: { title: string; detail: string; accent?: boolean }) {
  const theme = useHostTheme();
  return (
    <div
      style={{
        border: `1px solid ${accent ? theme.accent.primary : theme.stroke.secondary}`,
        borderRadius: 8,
        padding: 12,
        background: accent ? theme.fill.secondary : theme.bg.editor,
        minHeight: 76,
      }}
    >
      <Text weight="semibold" style={{ margin: 0 }}>{title}</Text>
      <Text tone="secondary" size="small" style={{ marginTop: 6, marginBottom: 0 }}>{detail}</Text>
    </div>
  );
}

function Arrow() {
  const theme = useHostTheme();
  return (
    <Text
      as="span"
      tone="tertiary"
      style={{ color: theme.text.tertiary, alignSelf: "center", textAlign: "center" }}
    >
      →
    </Text>
  );
}

function BoundaryItem({ children }: { children: string }) {
  return (
    <Row gap={8} align="start">
      <Text as="span" tone="tertiary">—</Text>
      <Text size="small" style={{ margin: 0 }}>{children}</Text>
    </Row>
  );
}

export default function BankaGstackIntegrationPlan() {
  const theme = useHostTheme();
  const dispatch = useCanvasAction();

  return (
    <Stack gap={24} style={{ padding: 24, maxWidth: 1180, margin: "0 auto" }}>
      <Stack gap={10}>
        <Row gap={8} align="center" wrap>
          <Pill active>Banka-native integration</Pill>
          <Pill>Planning blueprint</Pill>
        </Row>
        <H1>Banka–gstack integration plan</H1>
        <Text tone="secondary" style={{ maxWidth: 840, margin: 0 }}>
          Adopt gstack's strongest review habits as embedded Banka perspectives while preserving the ecosystem's authority boundaries, skill lifecycle, project-state tiers, and command surface.
        </Text>
        <Callout tone="success" title="Recommendation">
          Treat gstack as design research, not as a dependency, replacement workflow, Craft Layer module, or router. The integration belongs in Banka's existing skills.
        </Callout>
        <Row gap={28} wrap>
          <Stat value="0" label="new commands" tone="success" />
          <Stat value="0" label="new generated project files" tone="success" />
          <Stat value="3" label="primary skills refined" />
          <Stat value="1" label="pilot before expansion" />
        </Row>
      </Stack>

      <Divider />

      <Stack gap={12}>
        <H2>Preserved lifecycle</H2>
        <Grid columns="minmax(180px, 0.8fr) 28px minmax(180px, 0.9fr) 28px minmax(220px, 1.1fr) 28px minmax(180px, 0.8fr)" gap={8} align="stretch">
          <Stack gap={8}>
            <FlowNode title="Fresh project" detail="Decision-ready scope from ASMP or another valid source" />
            <FlowNode title="Brownfield project" detail="Readiness evidence from Docking when needed" />
          </Stack>
          <Arrow />
          <FlowNode title="Banka adoption" detail="Tier selection, state generation, runtime integration" />
          <Arrow />
          <FlowNode title="Existing Banka skills" detail="Charter → build → moor → survey → remember" accent />
          <Arrow />
          <FlowNode title="Execution + memory" detail="Perspectives shape thinking; Banka remains the operator" />
        </Grid>
        <Text tone="tertiary" size="small" style={{ margin: 0 }}>
          ASMP defines scope. Docking verifies readiness. Banka adopts and operates. Perspectives act only inside Banka's operational stage.
        </Text>
      </Stack>

      <Grid columns="repeat(auto-fit, minmax(300px, 1fr))" gap={16}>
        <Card>
          <CardHeader trailing={<Pill size="sm" active>Adopt</Pill>}>Transferable gstack patterns</CardHeader>
          <CardBody>
            <Stack gap={9}>
              <BoundaryItem>Challenge the premise and connect work to a real outcome.</BoundaryItem>
              <BoundaryItem>Make review posture explicit: expand, hold, or reduce scope.</BoundaryItem>
              <BoundaryItem>Describe realistic production failures for new paths and integrations.</BoundaryItem>
              <BoundaryItem>Verify claims with code, tests, or observed behavior.</BoundaryItem>
              <BoundaryItem>Test recurring user flows, not only entity and route coverage.</BoundaryItem>
            </Stack>
          </CardBody>
        </Card>
        <Card>
          <CardHeader trailing={<Pill size="sm">Exclude</Pill>}>gstack machinery that stays outside</CardHeader>
          <CardBody>
            <Stack gap={9}>
              <BoundaryItem>Its global router and proactive command dispatch.</BoundaryItem>
              <BoundaryItem>Its large specialist-command surface and autoplan pipeline.</BoundaryItem>
              <BoundaryItem>Its plan-file state, browser daemon, shipping, and deployment stack.</BoundaryItem>
              <BoundaryItem>Its fix-first review behavior, which conflicts with Banka survey's report-only contract.</BoundaryItem>
              <BoundaryItem>Its separate memory system, which would compete with moor and remember.</BoundaryItem>
            </Stack>
          </CardBody>
        </Card>
      </Grid>

      <Stack gap={12}>
        <H2>Perspective placement</H2>
        <Table
          headers={["Existing skill", "Embedded perspective", "Behavioral change"]}
          rows={skillRows}
          striped
          rowTone={["info", "info", "warning", "neutral", "neutral"]}
        />
        <Callout tone="warning" title="Important compatibility rule">
          Do not add optional `--mode` or `--perspective` invocation syntax in the first release. Banka supports more than one runtime and explicitly avoids relying on slash-command argument contracts. Earn explicit modes through pilot evidence first.
        </Callout>
      </Stack>

      <Stack gap={12}>
        <H2>Implementation sequence</H2>
        <Table
          headers={["Phase", "Outcome", "Work", "Primary placement"]}
          rows={phases}
          striped
          rowTone={["info", "info", "info", "warning", "success"]}
        />
      </Stack>

      <Grid columns="minmax(0, 1.15fr) minmax(280px, 0.85fr)" gap={20} align="start">
        <Stack gap={10}>
          <H2>Acceptance contract</H2>
          <BoundaryItem>A fresh project still enters through decision-ready scope and Banka adoption.</BoundaryItem>
          <BoundaryItem>A brownfield project still requires sufficient readiness evidence before adoption.</BoundaryItem>
          <BoundaryItem>The nine canonical Banka skills remain the same nine skills.</BoundaryItem>
          <BoundaryItem>No generated tier gains a perspectives file, review-gate file, or gstack configuration.</BoundaryItem>
          <BoundaryItem>Charter still pauses for approval; survey still reports and routes without fixing.</BoundaryItem>
          <BoundaryItem>Watershed remains the escalation path for contested decisions, not a routine gate.</BoundaryItem>
          <BoundaryItem>All three repository integrity checks pass after the Banka-only change.</BoundaryItem>
        </Stack>
        <Card>
          <CardHeader>Primary files to inspect</CardHeader>
          <CardBody>
            <Stack gap={10}>
              <Button variant="secondary" onClick={() => dispatch({ type: "openFile", path: "/Users/madridj1689/Code/projects/Banka/protocol/Banka.md" })}>
                Open Banka protocol
              </Button>
              <Button variant="secondary" onClick={() => dispatch({ type: "openFile", path: "/Users/madridj1689/Code/projects/Banka/skills-kit/charter/SKILL.md" })}>
                Open charter
              </Button>
              <Button variant="secondary" onClick={() => dispatch({ type: "openFile", path: "/Users/madridj1689/Code/projects/Banka/skills-kit/survey/SKILL.md" })}>
                Open survey
              </Button>
              <Button variant="secondary" onClick={() => dispatch({ type: "openFile", path: "/Users/madridj1689/Code/projects/Banka/skills-kit/watershed/SKILL.md" })}>
                Open watershed
              </Button>
              <Text tone="tertiary" size="small" style={{ margin: 0, color: theme.text.tertiary }}>
                ASMP and Docking should require no behavioral edits for this integration.
              </Text>
            </Stack>
          </CardBody>
        </Card>
      </Grid>

      <Divider />

      <Stack gap={6}>
        <H3>Deferred decision</H3>
        <Text tone="secondary" style={{ margin: 0 }}>
          After one or more real pilots, evaluate whether users repeatedly need to invoke a non-default perspective explicitly. Only then consider an optional mode or a new workflow—and require it to satisfy Banka's existing “repeatable workflow + unique rules + explicit invocation benefit” test.
        </Text>
      </Stack>
    </Stack>
  );
}
